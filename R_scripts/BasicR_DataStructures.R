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


# Creating factors 






