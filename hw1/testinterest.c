#include <stdio.h>

float moInterest(float p, float r)
{
	return p*(r/(1200));
}

int main()
{
	float p = 10000.0;
	float r = 6.0;
	printf("The monthly payments for p %f and r %f is %f\n", p, r, moInterest(p, r));
	return 0;
}

