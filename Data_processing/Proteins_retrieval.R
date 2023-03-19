# Imports
library(biomaRt)
library(dplyr)
library(tidyverse)

# Load data 
df <- read.csv("genes_NTDs.csv")

# Define the mart
mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")

# Look at attributes of mart
# symbol_att <- searchAttributes(mart = ensembl, pattern = "symbol")

# Search for longest transcripts of a list of genes
Protein_tbl <- getBM(attributes = c("entrezgene_id", "ensembl_gene_id", 
                                    "transcript_length"), 
                     filters = "entrezgene_id", 
                     values = df$entrezgene_id, 
                     mart = mart,
                     uniqueRows=TRUE)

# Sort table by Entrez gene ID and transcript length
Protein_tbl <- Protein_tbl[order(Protein_tbl$entrezgene_id, -Protein_tbl$transcript_length),]

# Keep only the row with the longest transcript for each Entrez gene ID
Protein_tbl <- Protein_tbl[!duplicated(Protein_tbl$entrezgene_id), c("entrezgene_id", "ensembl_gene_id")]

# Search for UniProt IDs of Ensembl gene IDs
UniProt_tbl <- getBM(attributes = c("ensembl_gene_id", "entrezgene_id", "uniprotswissprot",
                                    ""), 
                     filters = "ensembl_gene_id", 
                     values = Protein_tbl$ensembl_gene_id, 
                     mart = mart,
                     uniqueRows = TRUE)

# Change blank strings to NAs
UniProt_tbl$uniprotswissprot <- as.character(UniProt_tbl$uniprotswissprot)
UniProt_tbl$uniprotswissprot[UniProt_tbl$uniprotswissprot==""] <- NA
UniProt_tbl$uniprotswissprot<- as.factor(UniProt_tbl$uniprotswissprot)

# Remove rows with no uniprot information 
UniProt_tbl <- UniProt_tbl[!(is.na(UniProt_tbl$uniprotswissprot)), ]

# Add hgnc symbol
temp <- df[, 1:2]
df_final <- merge(UniProt_tbl, temp, by = "entrezgene_id")

# Remove duplicated rows
df_final <- unique(df_final)

# Remove NA rows
df_final <- na.omit(df_final)

# Export dataframe
write.csv(df_final, "../NTDs_proteins.csv", row.names = FALSE)
