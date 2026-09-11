#include <stdio.h>

double mean(double num1, double num2) {
    return (num1 + num2) / 2;
}

int sum_input() {
    int val; /* holds next integer value from standard input */
    int sum = 0; /* sum of input integers so far */
    while (scanf("%d", &val) != EOF)
        sum = sum + val;
    return sum;
}



int main(){
	printf("The call mean(5,8) returns  %f\n", mean(5,8));
	printf("Input integers separated by spaces or newlines, then press CTRL+D\n");
	int sum = sum_input();
	printf("The return value from calling sum_input() is %d\n", sum);
}
