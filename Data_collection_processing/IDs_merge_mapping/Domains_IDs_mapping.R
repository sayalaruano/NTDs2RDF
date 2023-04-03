# Get unique domains
df_domains   <- read.csv("../Data/CSV_files/Domains_NTDs_proteins.csv")
df_pfam_names <- read.csv("../Data/pfam_domainnames_mapping.csv")

# Merge domain ids
df_domains <- merge(df_domains, df_pfam_names, by = "InterPro_id", all.x = TRUE)

# Remove duplicated rows
df_domains <- unique(df_domains)

# Remove blank row
df_domains <- df_domains[-1,]

# Export dataframe
write.csv(df_domains, "../Data/CSV_files/Domains_NTDs_proteins.csv", row.names = FALSE)
