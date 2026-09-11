#include <stdio.h> 

float max(float x, float y){
	if (x > y)
		return x;
	else return y;
}

int main(){
	float x, y;
	printf("Please input two float numbers\n");
	scanf("%f\n", &x);
	scanf("%f\n", &y);
	printf("The maximum of %f and %f is %f", x, y, max(x, y));
	return 0;
}
