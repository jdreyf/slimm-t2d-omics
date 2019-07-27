library(ezlimma)
library(Mesa)

nsample <- 8
nperm <- 10**3
nsim <- 50
effect.v <- 0:3
load("data/smpdb_gmat.rda")

sim.m <- Mesa::sim_msa(msa.fcn=mesa, Gmat=smpdb_gmat, nsample=nsample, nsim=nsim, nperm=nperm, effect.v = effect.v, ncores=25)
write.csv(sim.m[1,, drop=FALSE], paste0("./validation/sim_msa_nperm", nperm, "_nsim", nsim, ".csv"), na="")
