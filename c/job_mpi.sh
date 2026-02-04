#!/bin/bash

#SBATCH --job-name=primes
#SBATCH --ntasks-per-node=4
#SBATCH --nodes=1

export PMIX_MCA=native
PRIMES_START=2
PRIMES_END=10000000

# Needed on Comet
module load OpenMPI

echo "Starting Multi-process primes calculation ($PRIMES_START - $PRIMES_END) x${SLURM_NTASKS}"
echo "====================="

time mpirun ./multi $PRIMES_START $PRIMES_END
echo "====================="
echo "Primes calculation complete"
