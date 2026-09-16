#include <stdio.h>
int main()
{
	int x = 37;
	printf("x has value %d in decimal and %x in hexadecimal.\n", x, (x>>5));
	return 0;
}
