#include <stdio.h>
int prod_array(int a[], int size) {
	int i, prod=1;
	for (i = 0; i < size; i++)
	prod = prod * a[i];
	return prod;
}

int main (){
	int arr[] = { 2, 4, 10 };
	int val = prod_array(arr, 3);
	printf("The product of array element is %d\n", val);
}
