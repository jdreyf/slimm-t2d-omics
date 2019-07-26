#' Reformat output tables from mediation simulations
#' 
#' Reformat output tables from mediation simulations.
#' 
#' @param tab Simulation output table
#' @param nm Name of mediation method

require(reshape2)

melt_sim_tab <- function(tab, nm){
  colnames(tab)[1] <- "t2"
  res <- melt(data=tab, value.name = nm)
  res <- apply(res, MARGIN = 2, FUN=function(v){
    sub(".+_", "", v)
  })
  colnames(res)[colnames(res)=="variable"] <- "b1"
  #reorder to match barfield
  res[, c(2, 1, 3)]
}
