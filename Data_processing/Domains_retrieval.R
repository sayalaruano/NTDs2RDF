# Imports
library(biomaRt)
library(dplyr)
library(tidyverse)

# Load data 
df <- read.csv("../NTDs_proteins.csv")

# show all elements of the data.frame
options(tibble.print_max = Inf)

# Define the mart
mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")

# search for GO terms of a list of genes
Domain_tbl <- getBM(attributes = c("uniprotswissprot", "entrezgene_id", "interpro", "interpro_short_description", "interpro_description"), 
               filters = "uniprotswissprot", 
               values = df$uniprotswissprot, 
               mart = mart)

# Remove duplicated rows
Domain_tbl <- unique(Domain_tbl)

# Change blank strings to NAs
Domain_tbl$interpro <- as.character(Domain_tbl$interpro)
Domain_tbl$interpro[Domain_tbl$interpro==""] <- NA
Domain_tbl$interpro <- as.factor(Domain_tbl$interpro)

# Remove rows with no GO information 
Domain_tbl <- Domain_tbl[!(is.na(Domain_tbl$interpro)), ]

# Export dataframe
write.csv(Domain_tbl, "../Domains_NTDs_proteins.csv", row.names = FALSE)
