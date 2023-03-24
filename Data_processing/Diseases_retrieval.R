# Imports 
library(DOSE)

# Load data 
df <- read.csv("genes_NTDs.csv")

# Over-representation analysis for disease ontology with the disease gene network
# Create an empty df
df_result <- data.frame()

for (i in df$entrezgene_id){
  
  # Get the enriched diseases 
  dgn <- enrichDGN(i)
  
  if(is.null(dgn)){
    next 
  }else{
    # Select the top 20 diseases 
    temp_df <- data.frame(entrezgene_id = dgn@result[1:30,]$geneID, 
                          disgenetID = dgn@result[1:30,]$ID, 
                          description = dgn@result[1:30,]$Description)
    
    # Merge the rows of the new gene
    df_result <- bind_rows(df_result, temp_df)
  }
}

# Remove duplicated rows
df_result <- unique(df_result)

# Remove NA rows
df_result <- na.omit(df_result)

# Export df
write.csv(df_result, "Assdiseases_genes_NTDs.csv", row.names = FALSE)
