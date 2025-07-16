#!/bin/bash

# Comment out all the 'module' lines if building on a local Linux system
# and not a Slurm/HPC/module based system.

CFLAGS=""
CFLAGS="-O2"
CFLAGS="-O3"
CFLAGS="-O3 -march=znver4 -mavx512f"

# Build the single process version using the GCC compiler
module purge 2>/dev/null
module load GCC

# Compile a GCC version
# ======================================
echo ""
echo "Compiling primes.c function..."
gcc $CFLAGS -c primes.c -o primes_gcc.o
echo "Compiling single process version..."
gcc $CFLAGS -c single.c -o single_gcc.o
echo "Creating executable binary..."
gcc -o single_gcc single_gcc.o primes_gcc.o && ls -l single_gcc

# Compile using AOCC
# ======================================
module purge 2>/dev/null
module load AOCC
echo ""
echo "Compiling primes.c function..."
clang -march=znver4 -mavx512f -O3 -c primes.c -o primes_aocc.o
echo "Compiling single process version..."
clang -march=znver4 -mavx512f -O3 -c single.c -o single_aocc.o
echo "Creating executable binary..."
clang -o single_aocc single_aocc.o primes_aocc.o && ls -l single_aocc

# Compile the mpi process version and link in the primeCount library
# ==================================================================
module purge 2>/dev/null
# Next line is for Comet
module load OpenMPI
# Next line is for Rocket
#module load mpi
echo ""
echo "Compiling primes.c function..."
mpicc $CFLAGS -c primes.c -o primes_mpi.o
echo "Compiling MPI multi-process version..."
mpicc $CFLAGS -c multi.c -o multi_mpi.o
echo "Creating executable binary..."
mpicc -o multi multi_mpi.o primes_mpi.o && ls -l multi

echo ""
