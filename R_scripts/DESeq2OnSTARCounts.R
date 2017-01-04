#==============================================================
# R Code for Example
#==============================================================

# Functions to load
getCountVector <- function(df, column=3, removerows=1:4){
    x <- df[-removerows, column]
    return(x)
}

getHtseqVector <- function(df, column=1){
    x <- df[, column]
    return(x)
}

# Set the working directory
setwd("C:/Users/Radia/Documents/Workshop_exercises/GCRC_session3-master/counts")

files <- list.files()

# Chose the order of the files to be loaded and store indices in ordinds
ordinds = c(2, 4) # Modify according to files
countDFlist <- lapply(files[ordinds], read.delim, header=FALSE, row.names=1) 

# Check the dataframes
head(lapply(countDFlist, head))

# rename the list items
names(countDFlist) <- files[ordinds]

# By choosing column 3 we are using stranded REVERSE or -s reverse parameter in HTSeq
countsMatrix <- sapply(countDFlist, getCountVector, column=3) 


# Add the gene names ------------------------------------------------
# If gene names in the data frames are the same i.e. TRUE add the gene names
if(identical(rownames(countDFlist[[1]]), rownames(countDFlist[[2]]))){

	geneNames <- rownames(countDFlist[[1]])[-c(1:4)]
	rownames(countsMatrix) <- geneNames

	# Organize the columns by group, if needed
	print(colnames(countsMatrix))

} 

# define the groups to add to the colData
groups <- c("Cancer1", "Cancer2")

#======================================================================
# Run DESeq2 on the raw counts matrix
#======================================================================
# Load the DESeq2 library (must be already installed to load)
library("DESeq2")

# Create the objects need to run DESeqDataSetFromMatrix() function
# for more info see help(DESeqDataSetFromMatrix)
coldat = DataFrame(grp=factor(groups, levels=c("Cancer1", "Cancer2")))
cnts = countsMatrix

dds <- DESeqDataSetFromMatrix(cnts, colData=coldat, design = ~ grp)
dds <- DESeq(dds)

## Extract results from DESeq2 analysis
res <- results(dds)
summary(res)

# Doing the normalization after filtering genes that are not expressed across the samples
dds1 <- dds[rowSums(counts(dds)) > 1, ]
rld1 <- rlogTransformation(dds1, blind=TRUE) # local regression fit was used to transform the data
head(assay(rld1))
M1 <- assay(rld1)

# Save the results for quick reload
save(cnts, dds, dds1, rld1, M1, coldat, countsMatrix, file="starDESeq2_Dec2016.rds") 

#------------------------------------
# Boxplot of gene expression data
#------------------------------------
# M1 <-assay(rld1)
par(mar=c(15,5,2,2))
boxplot(M1, col="blue", las=2, cex.axis=1)

fname="STAR_rlog_counts"
write.csv(M1, file=paste(fname, ".csv", sep=""))

#======================================================================
# Rerun the analysis this time adding the HTSeq counts
#======================================================================
# For the STAR counts ----------
# Chose the order of the files to be loaded and store indices in ordinds
ordinds = c(2, 4) # Modify according to files
countDFlist <- lapply(files[ordinds], read.delim, header=FALSE, row.names=1)

# Check the dataframes
head(lapply(countDFlist, head))

# rename the list items
names(countDFlist) <- files[ordinds]

# We want counts from stranded = yes to match the default parameter used in HTSeq
# Ideally you should rerun HTSeq by adding the parameter -s reverse
countsMatrix <- sapply(countDFlist, getCountVector, column=2) 


# If gene names in the data frames are the same i.e. TRUE add the gene names
if(identical(rownames(countDFlist[[1]]), rownames(countDFlist[[2]]))){

	geneNames <- rownames(countDFlist[[1]])[-c(1:4)]
	rownames(countsMatrix) <- geneNames

} 

# Inspect the countsMatrix
head(countsMatrix)
# Save the STAR counts to compare with HTSeq
STARcnts = countsMatrix

# For the HTSeq counts ----------
# Chose the order of the files to be loaded and store indices in ordinds
ordinds = c(3, 5) 
countDFlist <- lapply(files[ordinds], read.delim, header=FALSE, row.names=1)

# Check the dataframes
head(lapply(countDFlist, head))

# rename the list items
names(countDFlist) <- files[ordinds]

countsMatrix <- sapply(countDFlist, getHtseqVector)
head(countsMatrix)

# Add the gene names ------------------------------------------------
# If gene names in the data frames are the same i.e. TRUE add the gene names
if(identical(rownames(countDFlist[[1]]), rownames(countDFlist[[2]]))){

	geneNames <- rownames(countDFlist[[1]])
	rownames(countsMatrix) <- geneNames
} 

# Inspect the countsMatrix
head(countsMatrix)

# Save the STAR counts to compare with HTSeq
HTSeqcnts = countsMatrix

genes <- intersect(rownames(STARcnts), rownames(HTSeqcnts)) 
length(genes)
head(genes)

# Are the two cnts matrices identical?
identical(STARcnts[genes, ], HTSeqcnts[genes, ]) # No

# Combine counts and test differential expression between STAR and HTSeq
cnts = cbind(STARcnts[genes, ], HTSeqcnts[genes, ])


# Adjust the column names
colnames(cnts) <- c("SRR76_star", "SRR77_star", "SRR76_htseq", "SRR77_htseq")

# define the groups to add to the colData
groups <- c("STAR", "STAR", "HTSEQ", "HTSEQ")

#======================================================================
# Run DESeq2 on the raw counts matrix
#======================================================================
# Load the DESeq2 library (must be already installed to load)
require("DESeq2")

# Create the objects need to run DESeqDataSetFromMatrix() function
# for more info see help(DESeqDataSetFromMatrix)
coldat = DataFrame(grp=factor(groups, levels=c("STAR", "HTSEQ")))

dds <- DESeqDataSetFromMatrix(cnts, colData=coldat, design = ~ grp)
dds <- DESeq(dds)

## Extract results from DESeq2 analysis
res <- results(dds)
summary(res)
#head(as.data.frame(res))

# Doing the normalization after filtering genes that are not expressed across the samples
dds1 <- dds[rowSums(counts(dds)) > 1, ]
rld1 <- rlogTransformation(dds1, blind=TRUE) # local regression fit was used to transform the data
head(assay(rld1))
M1 <- assay(rld1)

# Save the results for quick reload
save(cnts, dds, dds1, rld1, M1, coldat, countsMatrix, file="strandedDESeq2_Dec2016.rds") 

#------------------------------------
# Boxplot of gene expression data
#------------------------------------
# M1 <-assay(rld1)
par(mar=c(15,5,2,2))
boxplot(M1, col="blue", las=2, cex.axis=1)

fname="StrandedSTARHTSeq_rlog_counts"
write.csv(M1, file=paste(fname, ".csv", sep=""))


#============================================================================================
# Calculate the sample to sample distances to look at the sample clustering
#============================================================================================
require("RColorBrewer")
require("gplots")

# Color palette
hmcol<- colorRampPalette(brewer.pal(9, 'GnBu'))(100)

distsRL <- dist(t(assay(rld1)))
mat<- as.matrix(distsRL)
rownames(mat) <- colData(dds1)$grp


hc <- hclust(distsRL)
par(mar=c(15,5,2,2))
heatmap.2(mat, Rowv=as.dendrogram(hc),
symm=TRUE, trace='none',
col = rev(hmcol), margin=c(13, 13), key.title="")
