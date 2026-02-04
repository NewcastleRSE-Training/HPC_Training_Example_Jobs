#!/bin/bash

##SBATCH --partition=short_free
#SBATCH --job-name=single
#SBATCH --tasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1

PRIMES_START=2
PRIMES_END=100000000

# Find all of the prime numbers in the sequence defined above.
# This is a sequential search, testing each number in turn.

echo "Starting single process primes calculation ($PRIMES_START - $PRIMES_END)"
echo "====================="

time ./single $PRIMES_START $PRIMES_END
echo "====================="
echo "Primes calculation complete"
