#include <stdio.h>
#include <stdbool.h>


void print20primes()
{

    int primes [20];
 
    // Special handling for the integer '2'
    primes[0] = 2;
 
    // Number of primes encountered
    int primeCount = 1;
 
    // Looping from 3, to the limit
    for (int i = 3; i <= 71; i++) {
        bool isPrime = true;
 
        if (i % 2 == 0) {
            continue;
        }
 
        for (int j = 0; j < primeCount; j++) {
            if (i % primes[j] == 0) {
                isPrime = false;
            }
        }
 
        // Store the prime number and increment the count
        if (isPrime) {
            primes[primeCount++] = i;
        }
    }
 
    // Print the primes
    for(int b = 0; b < 20; b++)
    {
    	printf("%d ", primes[b]);
    }
}
