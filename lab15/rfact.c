#include <stdio.h> 
int fact(int n) { /* n must be non-negative */
  if (n == 0)
    return 1;
  else
    return n * fact(n-1);
}

int main () {
	int x;
	printf("Please type a non-negative integer: \n");
	scanf("%d", &x);
	if(x < 0)
		return -1;
	printf("the factorial of %d is %d\n", x, fact(x) );
	return 0;
}
