#include <stdio.h>

int strlen(char str[]){
	int count = 0;
	char *strp = str;
	while (*strp != '\0'){
		strp += 1;
		count++;
	}
	return count;
}

int main(){
	int x;
	x = strlen("The end");
	printf("The length of 'The end' is %d\n", x);

}
