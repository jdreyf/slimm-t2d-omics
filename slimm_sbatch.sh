ssh jmd28@o2.hms.harvard.edu
cd /n/data1/joslin/cores/bbcore/slimm-t2d-omics
sbatch -p priority -t 1-0:0:0 --mem=5G run_val_mediate.sh
# sbatch -p priority -t 0-12:0:0 run_val.sh
# sbatch -p priority -t 0-43:0:0 --mem-per-cpu=5G -c 16 run_val_mesa.sh

# after: seff <jobid>
