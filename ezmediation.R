require(mediation)

# model-based approach from https://cran.r-project.org/web/packages/mediation/vignettes/mediation.pdf
# sims = 100, like 1st example in Model-based causal mediation analysis
ezmediation <- function(E, M, Y, covariates, sims=1000){
  stopifnot(ncol(as.matrix(covariates)) == 1)
  
  med.fit <- lm(M ~ E + covariates)
  out.fit <- lm(Y ~ M + E + covariates)
  
  med.out <- mediate(med.fit, out.fit, treat = "E", mediator = "M", sims = sims)
  # use d.avg.p =  average of average causal mediation effects per treatment & control
  res <- matrix(med.out$d.avg.p, nrow=1, ncol=1)
  colnames(res) <- "EMY.p"
  res
}