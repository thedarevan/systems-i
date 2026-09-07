#include <stdio.h>
#include <math.h>
int main(){
float v = 9;
if (v>0){
printf("%f is positive.\n", v);
}
else {
	if (v<0){
		printf("%f is negative.\n,", v );
	}
	else {
		printf("The number is zero.\n");
	}
}
printf("Guard 1: %d\n", (v == (int)v));
printf("Guard 2: %d\n", sqrt(v) == (int)sqrt(v));
}

