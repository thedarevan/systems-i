#include <stdio.h>
int main(){
	int x = 0xc93e;
	int y;
	printf("The value of x is %d in decimal, %x in hexadecimal\n", x, x);
	printf("Enter a hexadecimal integer:\n");
	scanf("%x", &y);
	printf("The value of %x hexadecimal is %d decimal\n", y, y);
	return 0;
}
