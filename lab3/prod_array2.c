#include <stdio.h>
int prod_array(int a[], int size) {
	int i, prod=1;
	for (i = 0; i < size; i++)
	prod = prod * a[i];
	return prod;
}

int main (){
	int arr[] = { 1, 2, 3, 4, 5 };
	int val = prod_array(arr, 5);
	printf("The product of array element is %d\n", val);
}
