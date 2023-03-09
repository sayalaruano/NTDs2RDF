# Imports
library(KEGGREST)
library(biomaRt)
library(dplyr)

# Get the kegg pathways info
chagas_kegg_path <- keggGet("hsa05142")[[1]]
leish_kegg_path <- keggGet("hsa05140")[[1]]
aftryp_kegg_path <- keggGet("hsa05143")[[1]]

# Get the list of numbers, gene symbols and gene description
chagas_genes <- chagas_kegg_path$GENE
leish_genes <- leish_kegg_path$GENE
aftryp_genes <- aftryp_kegg_path$GENE

# Delete the gene number by deleting every other line
chagas_genes <-  chagas_genes[seq(0,length(chagas_genes),2)]
leish_genes <-  leish_genes[seq(0,length(leish_genes),2)]
aftryp_genes <-  chagas_genes[seq(0,length(aftryp_genes),2)]

# Create a substring deleting everything after the ; on each line (this deletes the gene description).
chagas_genes <- gsub("\\;.*","",chagas_genes)
leish_genes <- gsub("\\;.*","",leish_genes)
aftryp_genes <- gsub("\\;.*","",aftryp_genes)

# Convert string list into a dataframe
df_chagasgenes <- data.frame(chagas_genes)
colnames(df_chagasgenes) <- "gene_name"
df_leish_genes <- data.frame(leish_genes)
colnames(df_leish_genes) <- "gene_name"
df_aftryp_genes <- data.frame(aftryp_genes)
colnames(df_aftryp_genes) <- "gene_name"

# Choose the Ensembl database and set the host
ensembl <- useMart("ENSEMBL_MART_ENSEMBL", dataset = "hsapiens_gene_ensembl")

# Retrieve gene symbols, gene names, and chromosome names for the specified Ensembl gene identifiers
chagas_ensembl_results <- getBM(attributes=c("hgnc_symbol", "entrezgene_id"),
                         filters = "hgnc_symbol",
                         values = df_chagasgenes$gene_name,
                         mart = ensembl,
                         uniqueRows = TRUE)

leish_ensembl_results <- getBM(attributes=c("hgnc_symbol", "entrezgene_id"),
                                filters = "hgnc_symbol",
                                values = df_leish_genes$gene_name,
                                mart = ensembl,
                                uniqueRows = TRUE)

aftryp_ensembl_results <- getBM(attributes=c("hgnc_symbol", "entrezgene_id"),
                                filters = "hgnc_symbol",
                                values = df_aftryp_genes$gene_name,
                                mart = ensembl,
                                uniqueRows = TRUE)

# Remove duplicates and add columns of disease
df_chagasgenes <- chagas_ensembl_results[-c(16, 17),]
df_chagasgenes["Disease"] <- "Chagas Disease"
df_chagasgenes["MESH ID"] <- "D014355"
df_leish_genes <- leish_ensembl_results[-c(17),]
df_leish_genes["Disease"] <- "Leishmaniasis"
df_leish_genes["MESH ID"] <- "D007896"
df_aftryp_genes <- aftryp_ensembl_results[-c(7),]
df_aftryp_genes["Disease"] <- "Trypanosomiasis, African"
df_aftryp_genes["MESH ID"] <- "D014353"

# Add NA value of unknown lesih gene
df_leish_genes[11,]$entrezgene_id <- 9103

# Merge the 3 dataframes in a single one
final_df <- bind_rows(df_chagasgenes, df_leish_genes, df_aftryp_genes)

# Export dataset
write.csv(final_df, "genes_NTDs.csv", row.names = FALSE)
