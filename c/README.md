# Prime Number Generator

This directory contains several flavours of a prime number generator written in C.

The conventional example in this directory works as follows:

   * You give it a number range, e.g. 2 to 10000
   * The function iterates over each integer in that range and determines if it is a prime number, if it is, then it increments a counter.
   * Once the entire range has been iterated, the counter (of how many primes are found) is returned.

For the parallel example we still define the search range, e.g 2 - 10000. The Slurm job defines the number of cores (and therefore the number of MPI processes) which are allocated. Then the logic is as follows:

   * Each MPI process gets 1/CPU_COUNT of the search range for itself. In the case of 4 CPU cores being allocated, then each MPI process would need to search:

   * (10000 - 2) / 4 = 2499 sequential numbers*

   * Each MPI process finds primes within its own range independently and simultaneously since it is running on an dedicated CPU.

   * Once all MPI processes have finished searching, they send their tally of found primes to the controll process, where it tallies them up. The tally should always match the same number found by the conventional sequential search.

Since each MPI process is only searching a fraction of the overall search space, the runtime of the MPI example is substantially reduced versus the sequential implementation.

*(***) Note: One of the MPI processes is always rounded up to the last search number, so we don't miss any by the integer rounding errors of splitting the search range.*

Files:

   * [primes.c](primes.c) - Implementation of the prime number generator, takes a start number and an end number and searches for all primes found between. Returns the number of primes found.
   * [primes.h](primes.h) - Header file/interface for the prime number generator function.
   * [single.c](single.c) - Simple sequential wrapper around the primes.c function. Makes a single call to search the entire search range. Can run without MPI/SLURM.
   * [multi.c](multi.c) - Wrapper which makes use of MPI to split the search range into regions which are handed off to MPI instances which find the primes in those sub-ranges independently and in parallel.
   * [job_single.sh](job_single.sh) - A SLURM sbatch job which runs the single, sequential search for a defined start and end point.
   * [job_mpi.sh](job_mpi.sh) - A SLURM sbatch job which uses MPI and mpirun to run the multi-instance parallel search version on a defined start and end space.

There are few support files which are not part of the code, but which are included to make running them easier:

   * [cleanup.sh](cleanup.sh) - Bash script to remove old object files.
   * [compile.sh](compile.sh) - Build the C code; the example is trivial enough to not need a makefile.

## Teaching Points

   * Shared, common core logic
   * Conventional, slow, iterative looping over an entire array of data
   * Being able to break data down into chunks which are relatively independent of each other, and being processed in parallel
   * Simple communication between processes to return independent result set to a master process for final calculation

## Example Performance figures

### Single Sequential Implementation

```
$ time ./single 2 10000000
```

Hardware #1

   * Intel Xeon E5 E5-2699 v4: 97.2 seconds

Hardware #2

   * Intel i7 13700K: 24.1 seconds

### Parallel Search Implementation

```
$ time mpirun -n $CPUS multi 2 10000000
```

Hardware #1

   * Intel Xeon E5 E5-2699 v4: 1x CPU = 98.3 wallclock seconds
   * 2x CPU = 67.6s
   * 4x CPU = 37.8s
   * 8x CPU = 21.2s
   * 16x CPU = 15.3s


Hardware #2

   * Intel i7 13700K: 1x CPU = 24.3 wallclock seconds
   * 2x CPU = 15.8s
   * 4x CPU = 8.8s
   * 8x CPU = 4.7s
   * 16x CPU = 3.4s
