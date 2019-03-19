##jmd
##2.28.18
##calc diff from baseline in gbww

make_diff_mat <- function(dat){
  nonbase.samps <- colnames(dat)[-grep("_0$", colnames(dat))]
  #subtract corresponding baseline from non-baseline value
  diff.dat <- dat[,nonbase.samps]-dat[,gsub('_.+', '_0', nonbase.samps)]
  diff.dat
}