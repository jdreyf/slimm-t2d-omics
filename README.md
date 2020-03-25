# slimm-t2d-omics
Analysis of omics data in SLIMM-T2D trial

## Download
1. Click on the green icon "Clone or download" then "Download ZIP"
2. Unzip

## Prerequisites
1. Download and Install R: https://cran.r-project.org/
2. Download and Install Free RStudio Desktop: https://rstudio.com/products/rstudio/download/

## Usage
1. Open analyze_slimm_t2d_omics.RMD in R Studio
2. Install and load necessary R packages, including ours such as `Hitman` as shown in beginning of analyze_slimm_t2d_omics.RMD.  
2. You can execute the R code in this file in blocks, or you can execute the entire file, including text, to produce a Microsoft Word file of the same name using the R Studio button "Knit". This will load our data from the `data` folder. The R files that created these R data objects are in the `data-raw` folder. It then applies our and other packages to  our data to reproduce the analyses from the paper.
3. You can compare the results to those at https://github.com/jdreyf/slimm-t2d-omics/tree/master/results.
4. You can recreate the supplementary Excel file from the `results` with write_supp_table.RMD, and you can reproduce the validations shown in the supplementary text with validate_methods.RMD.