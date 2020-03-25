# slimm-t2d-omics
Analysis of omics data in SLIMM-T2D trial

## Download
1. Click on the green icon "Clone or download" then "Download ZIP"
2. Unzip

You will see R Markdown files at the top level. The R Markdown (RMD) files have been executed to produce the Word documents. To reproduce the `results` from this paper, you can open and execute analyze_slimm_t2d_omics.RMD in RStudio. You can recreate the supplementary Excel file with write_supp_table.RMD, and you can reproduce the validations with validate_methods.RMD.

These RMDs use data from the `data` folder, which includes publically available pathways from SMPDB and a network from Pathway Commons. The `data-raw` folder has the R files that created these objects, with explanations at top.