#include <math.h>
#include <stdio.h>
int main(){
	int N = 5; /* number of square roots to print */
	int count = 0; /* loop control variable */
	/* invariant: count square roots have been printed so far */
	while (count < N) {
  	printf("%d\t%f\n", count+1, sqrt(count+1));
  	count = count + 1;
	}
}
