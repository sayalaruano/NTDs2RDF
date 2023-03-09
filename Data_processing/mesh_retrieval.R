# Imports
library(AnnotationHub)
library(MeSHDbi)
library(meshes)

# Load data
df <- read.csv("genes_NTDs.csv")


ah <- AnnotationHub(localHub=TRUE)
hsa <- query(ah, c("MeSHDb", "Homo sapiens"))
file_hsa <- hsa[[1]]
db <- MeSHDbi::MeSHDb(file_hsa)


x <- enrichMeSH(df$entrezgene_id[1], MeSHDb = db, database='gendoo', category = 'C')
