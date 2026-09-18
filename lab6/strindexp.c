#include <stdio.h>
int strindex(char str[], char c)
{
	char *p = str;
	int i = 0;
	while (*p != '\0')
	{
		if (*p == c)
			return i;
		i++;
		p++;
	}
	return -1;
}
int main()
{
	char str[] = "The end";
	char c = 'd';
	printf("The return value from strindex(\"The end\", \'e\') is %d\n", strindex(str, c));
	return 0;
}

