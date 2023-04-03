# Get unique domains
df_drugs   <- read.csv("../Data/CSV_files/drugs_NTDs.csv")
df_pubchem_chembl <- read.csv("../Data/drugs_mapping.csv")

# Merge refseq ids
df_drugs <- merge(df_drugs, df_pubchem_chembl, by = "Drugbank.ID", all = TRUE)

# Remove blank row by NA
df_drugs[df_drugs == ''] <- NA

# Remove duplicated rows
df_drugs <- unique(df_drugs)

# Remove CID from all of the PUBCHEM IDs
df_drugs <- df_drugs %>% mutate(PubChem.ID = str_replace(PubChem.ID, "CID", ""))

# Export dataframe
write.csv(df_drugs, "../Data/CSV_files/drugs_NTDs.csv", row.names = FALSE)
