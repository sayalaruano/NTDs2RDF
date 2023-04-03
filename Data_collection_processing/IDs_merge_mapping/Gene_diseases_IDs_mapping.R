# Imports
library(biomaRt)
library(dplyr)
library(tidyverse)

# Load data 
df_genes <- read.csv("../Data/genes_NTDs.csv")
df_disease_ids <- read.csv("../Data/diseases_IDs_mapping.csv")
df_gene_ids <- read.csv("../Data/genes_IDs_mapping.csv")

# Merge gene ids
df_genes <- merge(df_genes, df_ensembl, by = "hgnc_symbol")

# Merge disease ids
df_genes <- merge(df_genes, df_disease_ids, by = "MESH_id")

# Remove Orphanet_ from all of the IDs
df_genes <- df_genes %>% mutate(Orphanet_id = str_replace(Orphanet_id, "Orphanet_", ""))

# Remove MONDO_ from all of the IDs
df_genes <- df_genes %>% mutate(MONDO_id = str_replace(MONDO_id, "MONDO_", ""))

# Remove duplicated rows
df_genes <- unique(df_genes)

# Add leading 0s into MONDO IDs
# df_genes$MONDO_id <- sprintf("%07d", df_genes$MONDO_id)

# Export dataframe
write.csv(df_genes, "../Data/genes_NTDs.csv", row.names = FALSE)
