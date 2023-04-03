# Get unique domains
df_proteins   <- read.csv("../Data/CSV_files/NTDs_proteins.csv")
df_refseq <- read.csv("../Data/refseq_proteinnames_mapping.csv")
df_ensembl <- read.csv("../Data/ensembl_proteinnames_mapping.csv")

# Merge refseq ids
df_proteins <- merge(df_proteins, df_refseq, by = "UniProt_id", all = TRUE)

# Remove blank row
df_proteins <- df_proteins[-(1:19),]

# Merge ensembl ids
df_proteins <- merge(df_proteins, df_ensembl, by = "UniProt_id", all.x = TRUE)

# Remove duplicated rows
df_proteins <- unique(df_proteins)

# Export dataframe
write.csv(df_proteins, "../Data/CSV_files/NTDs_proteins.csv", row.names = FALSE)
