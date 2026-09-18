#include <stdio.h>
int getbit(int n,int i)
{
	return (n>>i)&1;
}

int main()
{
	int n = 37;
	for(int i = 0; i < 7; i++)
	{
		printf("%d", getbit(n, i));
	}
	printf("\n");
	return 0;
}
