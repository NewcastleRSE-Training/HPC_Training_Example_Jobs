#!/binsh
#
CFLAGS=""
echo $CFLAGS
gcc $CFLAGS -c primes.c -o primes_gcc.o
gcc  -c primes.c -o primes_gcc.o
gcc $CFLAGS -c single.c -o single_gcc.o
gcc -o single_gcc single_gcc.o primes_gcc.o && ls -l single_gcc
mpicc $CFLAGS -c primes.c -o primes_mpi.o
mpicc $CFLAGS -c multi.c -o multi_mpi.o
mpicc -o multi multi_mpi.o primes_mpi.o && ls -l multi
