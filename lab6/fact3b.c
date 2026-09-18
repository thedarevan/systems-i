#include <math.h>
#include <stdio.h>
int main(){
	int n;
	printf("Please input a number between 0 and 10:\n");
	scanf("%d", &n);
	if(n < 0 || n > 10){
		printf("Input is either too big or too small. Prepare to die.\n");
		return 1;
	}
	printf("k	k!\n");
	printf("-	----------\n");
	int i = 1;
	int f = 1;
	while(i <= n){
		printf("%d	%d\n", i, f);
		i++;
		f = i * f;
	}
	printf("The factorial of %d is %d\n", n, f);
	return 0;
}
