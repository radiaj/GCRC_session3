# GCRC_session3
This repository contains the R code and files to run the GCRC session 3 bioinformatics workshop examples.

# Instructions
Prior to the class, be sure to download and install the Rstudio Dektop and R on your laptop.

## To install R and RStudio Desktop
R can be downloaded for Linux, Mac and PC from https://cran.rstudio.com/. 
RStudio Desktop can be downloaded for Linux, Mac and PC at https://www.rstudio.com/products/rstudio/download3/.

Alternatively, you can run R on the Briaree cluster by adding the following module to your session and entering R on the terminal. 
```bash
# On Briaree in the terminal enter
module add R/3.2.1-gcc
R

```
## To Install DESeq2
You will also need to install the DESeq2 from Bioconductor. 
Open RStudio or start an R session on Briaree.
```R
# In your R session enter:
## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite("DESeq2")

# Test your installation
library("DESeq2")

# If you get error messages be sure you install the missing R packages mentioned in the error message with 
# install.packages()
# or if the missing package is on Bioconductor
# source("https://bioconductor.org/biocLite.R")
# biocLite("DESeq2")

```
See http://www.bioconductor.org/packages/release/bioc/html/DESeq2.html for more information on the DESeq2 package and dependencies.


