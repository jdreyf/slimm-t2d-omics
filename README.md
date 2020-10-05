# slimm-t2d-omics
Analysis and results from omics data in SLIMM-T2D trial. 

Results included here but not in the paper include integrative pathway analysis results with links to the pathway's analytes and statistics. These statistics are from the dataset of samples available from both proteomics and metabolomics, which is a different dataset than that for the analyte-level analysis, where metabolites and proteins were tested independently and included samples that only had data in either proteomics or metabolomics. For example, we only had proteomics but not metabolomics data at 24 months, so these data were included in the proteomics analysis, and should have some effect on other time points, since the pooled variance estimate uses data from all time points.

## Download
1. Click on the green icon "Clone or download" then "Download ZIP"
2. Unzip

## Prerequisites
1. Download and Install R: https://cran.r-project.org/
2. Download and Install Free RStudio Desktop: https://rstudio.com/products/rstudio/download/
3. On Windows, you should have [Rtools](https://cran.r-project.org/bin/windows/Rtools/).

## Usage
1. Open analyze_slimm_t2d_omics.RMD in R Studio
2. Install and load necessary R packages, including ours such as `Hitman` as shown in beginning of analyze_slimm_t2d_omics.RMD.  
	+ If asked "Do you want to install from sources the package which needs compilation?" say no.
3. You can execute the R code in this file in blocks, or you can execute the entire file, including text, to produce a Microsoft Word file of the same name using the R Studio button "Knit". This will load our data from the `data` folder. The R files that created these R data objects are in the `data-raw` folder. It then applies our and other packages to  our data to reproduce the analyses from the paper.
4. You can compare the results to those at https://github.com/jdreyf/slimm-t2d-omics/tree/master/results.
5. You can recreate the supplementary Excel file from the `results` with write_supp_table.RMD, and you can reproduce the validations shown in the supplementary text with validate_methods.RMD.