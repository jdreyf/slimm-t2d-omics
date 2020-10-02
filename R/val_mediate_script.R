# Chunk 1: setup
library(ezlimma)
library(Hitman)
library(mediation)

# Chunk 2
nsim <- 100
nsamp <- 50
nsamp.small <- 15
nperm <- 1000

ezmed <- Hitman:::ezmediate
prop.sig.med <- Hitman:::sim_barfield(med.fnm = "ezmed", b1t2.v=c(0, 0.14, 0.39), nsim = nsim, 
                                      nsamp = nsamp.small, sims=nperm)
write.csv(prop.sig.med, paste0("./validation/sim_mediate_nsamp", nsamp.small, "_nsim", nsim, "_nperm", nperm, ".csv"), na="")