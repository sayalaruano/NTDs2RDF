# Imports
library(biomaRt)
library(dplyr)
library(tidyverse)

# Load data 
df_genes <- read.csv("../Data/genes_NTDs.csv")
gene_names <- unique(df_genes$hgnc_symbol)
df_pharm_var <- read.table("../Data/Pharmgkb/clinicalVariants.tsv", sep = "\t", header = TRUE, fill = TRUE)
df_pharm_drugs <- read.table("../Data/Pharmgkb/drugs.tsv", sep = "\t", header = TRUE, fill = TRUE)

# Filter pharmgkb by NTDs genes 
df_filter <- filter(df_pharm_var, gene %in% gene_names)

# Filter rs variants 
df_rsvariants <- filter(df_filter, grepl("rs", variant))

# Define the mart
#hsapiens <- useMart("ENSEMBL_MART_ENSEMBL", dataset = "hsapiens_gene_ensembl")
snpmart <- useMart("ENSEMBL_MART_SNP", dataset = "hsapiens_snp")

# Search for UniProt IDs of Ensembl gene IDs
SNP_tbl <- getBM(attributes = c("refsnp_id","chr_name", 
                                "allele"), 
                 filters = "snp_filter", 
                 values = df_rsvariants$variant, 
                 mart = snpmart,
                 uniqueRows = TRUE)

# Filter snp table
test <- is.na(as.integer(SNP_tbl$chr_name))
SNP_tbl_filtered <- filter(SNP_tbl, !test)
colnames(SNP_tbl_filtered) <- c("variant", "chr_name", "allele")

# Merge chr name and allele
df_variants_final <- merge(df_rsvariants, SNP_tbl_filtered, by = "variant")

# Add entrez geneid
temp <- df_genes[, 1:2]
colnames(temp) <- c("gene", "entrezgene_id")
df_variants_final <- merge(df_variants_final, temp, by = "gene")

# Remove duplicated rows
df_variants_final <- unique(df_variants_final)

# Remove NA rows
df_variants_final <- na.omit(df_variants_final)

# Split delimited strings in chemicals column and insert as new rows
df_variants_final <- df_variants_final %>% separate_rows(chemicals, sep = ",")

# Merge with chemical ID
# Filter only drug names and ids
df_pharm_drugs_filter <- df_pharm_drugs[, 1:2]
colnames(df_pharm_drugs_filter) <- c("PharmGKB_ID", "chemicals")

# Merge drug ids 
df_variants_final <- merge(df_variants_final, df_pharm_drugs_filter, by = "chemicals")

# Split delimited strings in phenotypes column and insert as new rows
df_variants_final <- df_variants_final %>% separate_rows(phenotypes, sep = ",")

# Remove blankspaces in all columns 
df_variants_final <- df_variants_final %>% 
  mutate(across(where(is.character), str_trim))

# Remove duplicated rows
df_variants_final <- unique(df_variants_final)

# Remove NA rows
df_variants_final <- na.omit(df_variants_final)

# Export dataframe
write.csv(df_variants_final, "../Results/Variants_NTDs.csv", row.names = FALSE)
