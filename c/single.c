/*

This is a simple prime number calculator. It calls the primeCount library
with a number range (e.g. 1 to 1000) and calculates all the prime numbers
in that range; returning the total number calculated.

This is the most basic version; with the entire range being calculated
sequentially.

// John.Snowdon@newcastle.ac.uk, 2025.

*/

#include "primes.h"

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
	
	uint32_t total_primes = 0;
	uint32_t start = 0;
	uint32_t end = 0;
	
	if (argv[1]){
		start = atoi(argv[1]);
	}
	if (argv[2]){
		end = atoi(argv[2]);
	}
	
	if ((start < 2) || (end < 2)){
		printf("You must enter two positive numbers in the range 2 - 2^32\n");
		return 0;
	}
	
	printf("main: Calculating primes in the range %d - %d\n", start, end);
	total_primes = primeCount(start, end);
	printf("main: Found a total of %d primes\n", total_primes);
	return 0;
}