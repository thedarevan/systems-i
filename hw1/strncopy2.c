#include <stdio.h>

char *strncopy2(char *arr, char *str, int a) {
	int i = 0; /* index for the array str */

	/* invariant: the first i chars of str have been copied to arr */
	while (str[i] != '\0' && i < a) {
		arr[i] = str[i];
		i++;
	}

	arr[i] = '\0';
	return arr;
}

int main()
{
	char A[100];
	printf("%s\n", strncopy2(A, "The end", 5));
	return 0;
}
