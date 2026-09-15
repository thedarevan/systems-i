#include <stdio.h>

int copy_array(const int from_arr[], int a, int to_arr[])
{
	int counter = 0;
	while (counter < a)
	{
		to_arr[counter] = from_arr[counter];
		counter++;
	}
	return a;
}

int main()
{
	int from_arr[10];
	int to_arr[10];
	int counter = 0;
	int i = 0;
	printf("Please enter up to 10 integer values:\n");
	while (counter < 10 && scanf("%d", &from_arr[counter]) != EOF)
	{counter++;}

	copy_array(from_arr, counter, to_arr);
	printf("The values copied into the array are: \n");
	while (i < counter)
	{
		printf("%d, ", to_arr[i]);
		i++;
	}
	printf("\n");
	return 0;
}	
