#include <stdio.h>
int strlen(char str[]){
	int i =0;
	while (str[i] != '\0' ){
		i++;
	}
	return i;
}

int main(){
	int x;
	x = strlen("The end");
	printf("This string has %d characters.\n", x);
}
