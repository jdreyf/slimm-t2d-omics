# Chunk 1: setup
library(ezlimma)
library(Hitman)
library(mediation)

# Chunk 2
nsim <- 100
nsamp <- 50
nperm <- 1000

prop.sig.med <- Hitman:::sim_barfield(med.fcn = Hitman:::ezmediate, b1t2.v=c(0, 0.14, 0.39), nsim = nsim, 
                                      nsamp = nsamp, sims=nperm)
write.csv(prop.sig.med, paste0("./validation/sim_mediate_nsamp", nsamp, "_nsim", nsim, "_nperm", nperm, ".csv"), na="")
