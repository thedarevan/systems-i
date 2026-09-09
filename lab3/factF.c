#include <math.h>
#include <stdio.h>
int main(){
	int n = 5;
	int f = 1;
	for(int i = 1; i <= n; i++){
		f = i * f;
	}
	printf("The factorial of %d is %d\n", n, f);
	return 0;
}
