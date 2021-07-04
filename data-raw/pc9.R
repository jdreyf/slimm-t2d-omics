#' Pathway Commons v9 as an edge-list
#'
#' Pathway Commons v9 was downloaded as a SIF file. SIF is described at \url{http://www.pathwaycommons.org/pc/sif_interaction_rules.do}. 
#' It was then converted to an edge-list. Genes are represented by gene symbol (hgnc) and metabolites by CHEBI ID. 
#' All of the data provided by Pathway Commons is free. In particular, Pathway Commons distributes pathway 
#' information with the intellectual property restrictions of the source database; only databases that are freely 
#' available for academics were included in the SIF file.
#'
#' @format A matrix with >1 million rows and 2 columns, representing: physical_entity_id1 & physical_entity_id2.
#' @source \url{http://www.pathwaycommons.org/archives/PC2/v9/PathwayCommons9.All.hgnc.sif.gz}

# install.packages("remotes")
# remotes::install_github("jdreyf/ezlimmaplot")
library(ezlimmaplot)
library(devtools)

pc9 <- read.table('B:/annotations/pwy_commons/PathwayCommons9.All.hgnc.sif')
# remove water
pc9 <- ezlimmaplot::sif2edgelist(pc9, rm.ids="CHEBI:15377")

stopifnot(ncol(pc9) == 2)
stopifnot(!apply(pc9, 1, FUN=is.unsorted))

devtools::use_data(pc9, overwrite = TRUE)
