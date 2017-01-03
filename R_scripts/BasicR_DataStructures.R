# This R script goes over the basics of R programming for more details see Chapter 1. Programming with R from
# Gerrard, Paul, and Radia M. Johnson. Mastering Scientific Computing with R. Birmingham, England: Packt, 2015. Print. 

# Creating vectors in R
x <- c(2, 4, 5, 6)
x
print(x)

favoriteColors <- c("red", "blue", "green", "grey")

# Retrieving information by index position
x[2]
favoriteColors[2]
favoriteColors[c(1, 3)]
favoriteColors[1:3]

# Naming vector indices
names(x) <- c("A", "B", "C", "D")
x

y <- c(3.5, 2.4, 1.3, 12)
names(y) <- favoriteColors
y

# Retrieving vector content by name
x["B"]
y["blue"]


# Creating matrices with the rbind() and cbind() function
# Eg, 2x4 matrix with rows defined as x and y
mat1 <- rbind(x, y)
mat1

# Eg. 4x2 matrix with columns defined as x and y
mat2 <- cbind(x, y)
mat2

# Creating a matrix from a vector and the matrix() function
values <- c(x, y)
values
mat3 <- matrix(values, ncol=4, byrow=TRUE)
mat3

# Retrieving information from matrices by (x, y) coordinates 
mat3[2, 2]

# Returning the full row by index position
mat3[1, ] 
mat3[2, ]
mat2[4, ]

# Returning the full column by index position
mat3[, 1] 
mat3[, 2]
mat3[, 4]

# Adding row names and column names with teh rownames() and colnames() function, respectively.
rownames(mat3) <- c("Sample1", "Sample2")
colnames(mat3) <- c("geneA", "geneB", "geneC", "geneD")
mat3

# Retrieving information from a matrix from its row and column names
mat3["Sample1", ]
mat3[, "geneA"]
mat3[, "geneD"]

# Adding rows and columns to a matrix with the rbind() and cbind() function, respectively.
Sample3 <- c(1, 3, 9, 17)
mat <- rbind(mat3, Sample3)
mat

# Adding geneE values for all 3 samples in mat
geneE <- c(28, 32, 11)
mat <- cbind(mat, geneE)
mat

# Creating factors (specialized vectors that defines the groups)
drugRx <- factor(c("Placebo", "DrugA 50ug", "DrugA 100ug", "Placebo"))
drugRx

# To reorder factor levels
drugRx <- factor(c("Placebo", "DrugA 50ug", "DrugA 100ug", "Placebo", "DrugA 50ug", "DrugA 100ug"), levels=c("Placebo", "DrugA 50ug", "DrugA 100ug"))
drugRx

# To see the levels of a factor
levels(drugRx)

# Examples to show how to use factors to simplify analysing data by group 
survDays <- c(10, 20, 15, 9, 22, 25)
boxplot(survDays ~ drugRx, ylab="Survival (days)", col=c("grey", "cyan", "orange"))

# Summarising information by group using the by() and summary() function
by(survDays, drugRx, summary)

# Creating data frames
df1 <- data.frame(survDays, drugRx)
df1

# Adding rownames and colnames to dataframes
rownames(df1) <- letters[1:6]
colnames(df1) <- c("Survival", "Treatment")

# Retrieving the vectors that make up the dataframes by column
df1[, 1]
df1$Survival
df1[, 2]
df1$Treatment

# Adding columns to data frames
df1$Batch <- factor(c("A", "A", "A", "B", "B", "B"))
df1$CellPassage <- rep(1:2, each=3)

# To remove rows and columns
df1[-3, ]
df1[-c(1:3), ]
df1[, -2]
df1[, -c(2:3)]
    
# To evaluate the structure of your objects with the str() function
str(df1)
str(mat)

# Change the contents of a columm using the as.factor(), as.character(), as.numeric(), and as.integer()
df2 <- df1
df2$CellPassage <- as.factor(df1$CellPassage)
df2$Treatment <- as.character(df1$Treatment)
df2$Survival <- as.numeric(df1$Survival)
df2

str(df1)
str(df2)

df2$Survival <- as.integer(df2$Survival)
str(df2)

# Saving and reading csv files with the write.csv() and read.csv()
write.csv(df2, file="DataStructureDF1.csv")
dataDF1 <- read.csv("DataStructureDF1.csv")

# Other useful functions and the help() function
help(read.delim)
help(summary)











