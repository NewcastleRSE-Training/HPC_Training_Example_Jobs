#!/bin/bash

#SBATCH --partition=low-latency_paid
#SBATCH --job-name=primes_c
#SBATCH --ntasks-per-node=16
#SBATCH --nodes=1


PRIMES_START=2
PRIMES_END=10000000

# Needed on Comet
module load OpenMPI

# Needed on Rocket
#module load intel

echo "Starting Multi-process primes calculation ($PRIMES_START - $PRIMES_END) x${SLURM_NTASKS}"
echo "====================="

time mpirun ./multi $PRIMES_START $PRIMES_END
echo "====================="
echo "Primes calculation complete"
