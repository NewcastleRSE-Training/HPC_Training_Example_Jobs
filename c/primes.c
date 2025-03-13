#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>

#include "primes.h"

// John.Snowdon@newcastle.ac.uk, 2025.

uint32_t primeCount(uint32_t start, uint32_t end){
	// Calculate all of the primes between start and end
	// Return a count of how many primes have been found
	// This is *not* the most optimised version, but serves
	// to illustrate the differences in sequential vs parallel processing.

	uint32_t prime_count = 0;
	uint32_t not_prime_count = 0;
	uint32_t div_count = 0;
	uint32_t start_num, end_num, i;
	
	printf("primeCount: Calculating primes %d - %d\n", start, end);
	
	for (start_num = start; start_num <= end; start_num++){
		
		div_count = 0;

        for (i = 2; i * i <= start_num; i++){
            if (start_num % i == 0){
				div_count++;
			}
        }

        if (div_count > 0){
        		// Not prime
        		not_prime_count++;
		} else {
			// Prime
			prime_count++;
		}
    }
    printf("primeCount: Found %d primes\n", prime_count);
	return prime_count;
}