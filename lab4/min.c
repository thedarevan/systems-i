#include <stdio.h> 

float min(float x, float y){
	if (x < y)
		return x;
	else return y;
}

int main(){
	float x, y;
	printf("Please input two float numbers\n");
	scanf("%f\n", &x);
	scanf("%f\n", &y);
	printf("The call min(%f, %f) returns the value  %f", x, y, min(x, y));
	return 0;
}
