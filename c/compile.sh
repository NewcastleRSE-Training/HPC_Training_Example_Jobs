#!/bin/bash

# On Rocket, load the intel compiler module which include MPI
module purge
module load intel

# Compile the common primeCount function
# ======================================
echo ""
echo "Compiling primes.c function..."
gcc -c primes.c -o primes.o
echo "Compiling single process version..."
gcc -c single.c -o single.o
echo "Creating executable binary..."
gcc -o single single.o primes.o && ls -l single


# Compile the mpi process version and link in the primeCount library
# ==================================================================
echo ""
echo "Compiling MPI multi-process version..."
mpicc -c multi.c -o multi.o
echo "Creating executable binary..."
mpicc -o multi multi.o primes.o && ls -l multi

echo ""