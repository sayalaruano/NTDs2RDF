# Imports
library(biomaRt)
library(dplyr)
library(tidyverse)

# Load data 
df_prot <- read.csv("../Results/NTDs_proteins.csv")
df_drug <- read.csv("../Data/drugs_NTDs.csv")

# Add uniprot ID
temp <- df_prot[, c("entrezgene_id", "uniprotswissprot")]

df_drug <- merge(df_drug, temp, by = "entrezgene_id")

# Remove duplicated rows
df_drug <- unique(df_drug)

# Remove NA rows
df_drug <- na.omit(df_drug)

# Export dataframe
write.csv(df_drug, "../Data/drugs_NTDs.csv", row.names = FALSE)

# Load 
df_drug <- read.csv("../Data/CSV_files/drugs_NTDs.csv")

test <- data.frame(unique(df_drug$Drugbank.ID))
write.csv(test, "unique_drugs.csv", row.names = FALSE)
