#include <stdio.h>
void strncopyp(char char_array[], char str[], int num ){
	char *c = char_array;
	char *s = str;
	int count = 0;
	while (*s != '\0' && count < num){
		*c = *s;
		c++;
		s++;
		count++;
	}
	char_array[count] = '\0';
	
}

int main(){
	char A[100];
	strncopyp(A, "The end", 5);
	printf("%s\n", A);
	
}
