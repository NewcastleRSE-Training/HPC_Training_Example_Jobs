#!/bin/bash

# Comment out all the 'module' lines if building on a local Linux system
# and not a Slurm/HPC/module based system.

# Build the single process version using the GCC compiler
module purge
module load GCC

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
module purge
# Next line is for Comet
module load OpenMPI
# Next line is for Rocket
#module load mpi
echo ""
echo "Compiling MPI multi-process version..."
mpicc -c multi.c -o multi.o
echo "Creating executable binary..."
mpicc -o multi multi.o primes.o && ls -l multi

echo ""
