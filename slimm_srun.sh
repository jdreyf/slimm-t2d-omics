ssh jmd28@o2.hms.harvard.edu
srun --pty -p interactive -t 0-12:0:0 --mem-per-cpu=6000 -c 16 /bin/bash
srun --pty -p interactive -c 1 -t 0-12:0:0 /bin/bash
module load gcc
module load R
R
setwd("/n/data1/joslin/cores/bbcore/slimm-t2d-omics/")
