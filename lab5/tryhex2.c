#include <stdio.h>
int main(){
	int x = 0xc93e;
	int y;
	printf("The value of x is %d in decimal, %x in hexadecimal\n", x, x);
	printf("Emter a decimal integer:\n");
	scanf("%d", &y);
	printf("The value of %d decimal is %x hexadecimal\n", y, y);
	return 0;
}
