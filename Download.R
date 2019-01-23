#install.packages('rentrez')
library(rentrez)

# Creates vector of NCBI reference numbers for Borrelia sequences
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

# Passes reference numbers through NCBI database and loads select sequences as FASTA files
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

# Splits the Bburg string by the '>' character and separates sequences into elements in a list
Bsequences <- strsplit(Bburg, split = '>')[[1]]
Bseq <- lapply(Bsequences, function(x){x[!x ==""]})
Bseq[[1]] <- NULL

# convert list into a vector
unlist(Bseq, use.names = FALSE)

#substitute out the headers
Bseq2 <- gsub('.*partial sequence', '', Bseq)
Bseq3 <- gsub('\n', '', Bseq2)

# sets column names and writes to Sequences.csv file
columns = c('referenceID', 'Sequence')
write.csv(Bseq3, file = 'Sequences.csv', row.names = ncbi_ids)
