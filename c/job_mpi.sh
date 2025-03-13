#!/bin/bash

#SBATCH --job-name=primes_c
#SBATCH --tasks=1
#SBATCH --nodes=1
#SBATCH -c 8

PRIMES_START=2
PRIMES_END=10000000

module load intel

# Find all of the prime numbers in the sequence defined above.
# This is a parallel search, with one MPI instance per CPU allocated
# to the job.
# Each MPI instance is allocated 1/c of the entire search range, where
# c == number of allocated CPUs.
# The range is then searched in parallel and each MPI instance returning the
# found primes to the controlling instance.
# The number of found primes should be identical to the sequential search.

echo "Starting Multi-process primes calculation ($PRIMES_START - $PRIMES_END) x${SLURM_CPUS_PER_TASK}"
echo "====================="
time mpirun -np ${SLURM_CPUS_PER_TASK} ./multi $PRIMES_START $PRIMES_END
echo "====================="
echo "Primes calculation complete"