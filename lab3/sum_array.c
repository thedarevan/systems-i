#include <stdio.h>
double sum_arrayd(double a[], int size) {
	int i;
	double sum = 0;
	for (i = 0; i < size; i++){
	sum = sum + a[i];}
	return sum;
}

int main (){
	double  arr[] = { 3.14,  72.6, 45, -13.8};
	double val = sum_arrayd(arr, 4);
	printf("The sum  of array element is %f\n", val);
}
