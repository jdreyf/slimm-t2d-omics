#' Pathway inclusion matrix (Gmat) constructed from SMPDB.
#'
#' Pathway inclusion matrix (Gmat) constructed from http://smpdb.ca/downloads. These downloads are from 2014-2016. 
#' New downloads from early 2018 have very different pathways, with many nearly identical fatty acid biosynthesis 
#' pathways, so this object has not been updated with them. Code to reproduce this dataset from these downloads is at
#' https://github.com/jdreyf/PANTS/blob/master/data-raw/smpdb_gmat.R.
#'
#' @format A Matrix of features (proteins/metabolites) by Pathway names. Zero entries indicate the feature is not in the pathway,
#' whereas non-zero entries indicates otherwise.

library(devtools)
library(PANTS)
options(stringsAsFactors = FALSE)
setwd("//jdcfs1/cores/bioinformatics")
source('fcns/PANTS/R/SMPDB2Gmat.R')

smpdb.prot <- read.csv('annotations/smpdb/smpdb_proteins.csv')
smpdb.met <- read.csv('annotations/smpdb/smpdb_metabolites.csv')
smpdb_gmat <- SMPDB2Gmat(smpdb.prot=smpdb.prot, smpdb.met=smpdb.met, 
                         exclude.pwy.subj = c('Disease', 'Drug Action', 'Physiological', 'Signaling', 'Drug Metabolism'))
devtools::use_data(smpdb_gmat, overwrite = TRUE)
