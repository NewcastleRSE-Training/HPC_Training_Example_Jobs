/*

This is a simple prime number calculator. It calls the primeCount library
with a number range (e.g. 1 to 1000) and calculates all the prime numbers
in that range; returning the total number calculated.

The range is split into sub-ranges which are calculated in parallel using
multiple instances of this programme controlled by MPI, with the answers
from each instance returned to the parent to calculate the total number.

We use the same prime number calculator function, primeCount() as the sequential version,
so we can demonstrate that we did not have to change the core logic of our
application.

Some sample figures
===================

1) Intel i7 13700K

	mpirun -n 1 multi 2 10000000 == 24.3 wallclock seconds
	mpirun -n 2 multi 2 10000000 == 15.8 wallclock seconds
	mpirun -n 4 multi 2 10000000 == 8.8 wallclock seconds
	mpirun -n 8 multi 2 10000000 == 4.7 wallclock seconds
	mpirun -n 16 multi 2 10000000 == 3.4 wallclock seconds
		
2) Intel Xeon E5 E5-2699 v4

	mpirun -n 1 multi 2 10000000 == 98.3 wallclock seconds	
	mpirun -n 2 multi 2 10000000 == 67.6 wallclock seconds
	mpirun -n 4 multi 2 10000000 == 37.8 wallclock seconds
	mpirun -n 8 multi 2 10000000 == 21.2 wallclock seconds
	mpirun -n 16 multi 2 10000000 == 15.3 wallclock seconds

John.Snowdon@newcastle.ac.uk, 2025.
	
*/

#include "primes.h"

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

int main(int argc, char *argv[]){
	
	uint32_t total_primes = 0;
	uint32_t start, our_start = 0;
	uint32_t end, our_end = 0;
	uint32_t total_range, sub_range_size = 0;
	uint32_t found_primes = 0;
	
	int sub_process_id, process_id, cluster_size;
	
	if (argv[1]){
		start = atoi(argv[1]);
	}
	if (argv[2]){
		end = atoi(argv[2]);
	}
	
	if ((start == 0) || (end == 0)){
		printf("You must enter two positive numbers in the range 1 - 2^32\n");
		return 0;
	}

	// Set up the MPI data structures
	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &cluster_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &process_id);
	
	printf("main[%d]: Started process\n", process_id);
		
	// Calculate the sub-range that this instance is going to process
	total_range = end - start;
	sub_range_size = total_range / cluster_size;
	our_start = start + (process_id * sub_range_size);
	
	if (process_id > 0){
		our_start = our_start + process_id;
	}
	
	our_end = our_start + sub_range_size;
	
	if (our_end > end){
		our_end = end;
	}
	
	if (process_id == 0){
		printf("main[%d]: Total range is %d\n", process_id, total_range);
		printf("main[%d]: Sub-range per instance is %d\n", process_id, sub_range_size);
	}
	
	printf("main[%d]: Calculating primes %d - %d\n", process_id, our_start, our_end);
	found_primes = primeCount(our_start, our_end);
	printf("main[%d]: Found %d primes\n", process_id, found_primes);
	
	// Send found_primes from each of the instances (other than instance 0)
	if (process_id != 0){
		MPI_Send(&found_primes, 1, MPI_INT, 0, 1, MPI_COMM_WORLD);
	} 
	
	// Process_id 0 recieves the found_primes totals from each sub instance
	if (process_id == 0) {
		printf("main[%d]: Now waiting for results from instances...\n", process_id);
		total_primes += found_primes;
		for (sub_process_id = 1; sub_process_id < cluster_size; sub_process_id++){
			found_primes = 0;
			MPI_Recv(&found_primes, 1, MPI_INT, sub_process_id, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
			printf("main[%d]: Got %d from [%d]\n", process_id, found_primes, sub_process_id);
			total_primes += found_primes;
		}
	}
	
	// Wait for all sub instances to complete
	MPI_Finalize();
	
	if (process_id == 0){
		printf("main[%d]: Found a total of %d primes\n", process_id, total_primes);
	}
	
	return 0;
}