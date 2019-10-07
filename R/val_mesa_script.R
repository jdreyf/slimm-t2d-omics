library(ezlimma)
library(Hitman)
library(Mesa)

# Chunk 8
# Declare variables.
nsample <- 10
nperm <- 10**3
nsim <- 1000
effect.v <- 0:3

data("gmat_hallmark_subset")
data("chimera_cov_mat")

sbm.mesa <- sim_barfield_msa(msa.fnm="mesa", cov.mat=chimera_cov_mat, gmat=gmat_hallmark_subset, b1t2.v=c(0, 0.14),
                             alpha=0.05, nsamp=nsamp, nsim=nsim, nperm=nperm, verbose=FALSE)
write.csv(sbm.mesa, paste0("./validation/sim_msa_nperm", nperm, "_nsim", nsim, ".csv"), na="")
