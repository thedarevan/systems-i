#include <stdio.h>
int read_string(char word[], int max){
	int i = 0;
	char c;

	scanf("%c", &c);
	while (c != '\n' && i < max - 1 && c != EOF){
		word[i] = c;
		i++;
		scanf("%c", &c);
	}
	word[i] = '\0';
	return i;
}

int main(){
	char carr[50];
	int r = read_string(carr, 50);
	printf("%s\n", carr);
	printf("%d characters were stored\n", r);
	return 0;
}
