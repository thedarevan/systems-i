#include <stdio.h>

int power(int base, int exp){
	int pwr = 1;
	for(int i = 0; i < exp; i++){
		pwr = pwr*base;}	
	return pwr;
}

int main(void){
    /* test cases */
    printf("3**2: %d (should be 9)\n", power(3,2));
    printf("4**4: %d (should be 256)\n", power(4,4));
    printf("2**6: %d (should be 64)\n", power(2,6));
    printf("10**3: %d (should be 1000)\n", power(10,3));
    printf("5**0: %d (should be 1)\n", power(5,0));

    return 0;
}

