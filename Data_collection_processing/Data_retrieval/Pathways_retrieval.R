# Imports 
library(clusterProfiler)
library(ReactomePA)

# Load data 
df <- read.csv("genes_NTDs.csv")

# Over-representation analysis for disease ontology with wiki pathways
# Create an empty df
df_result_wp <- data.frame()

for (i in df$entrezgene_id){
  
  # Get the enriched pathways 
  wps <- enrichWP(i, organism = "Homo sapiens")
  
  if(is.null(wps)){
    next 
  }else{
    # Select the top 50 pathways 
    temp_df <- data.frame(entrezgene_id = wps@result[1:50,]$geneID, 
                          wikipathID = wps@result[1:50,]$ID, 
                          description = wps@result[1:50,]$Description)
    
    # Merge the rows of the new gene
    df_result_wp <- bind_rows(df_result_wp, temp_df)
  }
}

# Remove duplicated rows
df_result_wp <- unique(df_result_wp)

# Remove NA rows
df_result_wp <- na.omit(df_result_wp)

# Export results 
write.csv(df_result_wp, "../Wikipaths_genes_NTDs.csv", row.names = FALSE)

# Over-representation analysis for disease ontology with kegg
# Create an empty df
df_result_react <- data.frame()

for (i in df$entrezgene_id){
  
  # Get the enriched pathways 
  react <- enrichPathway(gene = i, 
                        pvalueCutoff = 0.05, 
                        readable=TRUE)
  
  if(is.null(react)){
    next 
  }else{
    # Select the top 50 pathways 
    temp_df <- data.frame(hgnc_symbol = react@result[1:50,]$geneID, 
                          reactpathID = react@result[1:50,]$ID, 
                          description = react@result[1:50,]$Description)
    
    # Merge the rows of the new gene
    df_result_react <- bind_rows(df_result_react, temp_df)
  }
}

# Add entrezgeneid
temp <- df[, 1:2]
df_result_react <- merge(df_result_react, temp, by = "hgnc_symbol")

# Remove duplicated rows
df_result_react <- unique(df_result_react)

# Remove NA rows
df_result_react <- na.omit(df_result_react)

# Export results 
write.csv(df_result_react, "Reactomepaths_genes_NTDs.csv", row.names = FALSE)
