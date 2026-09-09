#include <math.h>
#include <stdio.h>
int main(){
	int n = 0;
	int i = 1;
	int f = 1;
	while(i <= n){
		f = i * f;
		i = i + 1;
	}
	printf("The factorial of %d is %d\n", n, f);
	return 0;
}
