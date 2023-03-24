# Imports
library(biomaRt)
library(dplyr)
library(tidyverse)

# Load data 
df <- read.csv("../Data/CSV_files/genes_NTDs.csv")

# show all elements of the data.frame
options(tibble.print_max = Inf)

# Define the mart
mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")

# search for GO terms of a list of genes
GO_tbl <- getBM(attributes = c("hgnc_symbol", "entrezgene_id", "go_id", "name_1006", "namespace_1003"), 
               filters = "hgnc_symbol", 
               values = df$hgnc_symbol, 
               mart = mart)

# search for GO terms of an example Homo sapiens gene
#GO_tbl <- getGO(organism = "Homo sapiens", 
 #                         genes    = df$hgnc_symbol,
  #                        filters  = "hgnc_symbol")

# Remove duplicated rows
GO_tbl <- unique(GO_tbl)

# Remove rows with no GO information 
GO_tbl <- GO_tbl[!(is.na(GO_tbl$go_id) | GO_tbl$go_id==""), ]

# Remove GO: from all of the IDs
GO_tbl <- GO_tbl %>% mutate(go_id = str_replace(go_id, "GO:", ":"))

# Split the GOs considering cellular location, biological process and molecular function
list_dfs <- GO_tbl %>% group_by(namespace_1003)
list_dfs <- group_split(list_dfs)

# Extract dataframes
bp_df <- list_dfs[[1]]
cel_df <- list_dfs[[2]]
mf_df <- list_dfs[[3]]

# Load data 
bp_df <- read.csv("../Data/CSV_files/GO_biologicalprcoess_NTDs_genes.csv")
cel_df = read.csv("../Data/CSV_files/GO_cellularcomp_NTDs_genes.csv")
mf_df = read.csv("../Data/CSV_files/GO_molfunction_NTDs_genes.csv")

# Convert GO column into string
# Export dataframe
write.csv(bp_df, "../Data/CSV_files/GO_biologicalprcoess_NTDs_genes.csv", row.names = FALSE)
write.csv(cel_df, "../Data/CSV_files/GO_cellularcomp_NTDs_genes.csv", row.names = FALSE)
write.csv(mf_df, "../Data/CSV_files/GO_molfunction_NTDs_genes.csv", row.names = FALSE)
