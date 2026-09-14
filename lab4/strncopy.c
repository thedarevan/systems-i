#include <stdio.h>
void strncopy(char char_array[], char str[], int num ){
	int count = 0;
	while (count < num &&  str[count] != '\0'){
		char_array[count] = str[count];
		count++;
	}
	char_array[count] = '\0';
	
}

int main(){
	char A[100];
	strncopy(A, "The end", 5);
	printf("%s\n", A);
	
}
