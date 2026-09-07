#include <stdio.h>
#include <math.h>
int main(){
for (int v = -1; v <= 1; v++) {

if (v>0){
printf("%d is positive.\n", v);
}
else {
        if (v<0){
                printf("%d is negative.\n", v );
        }
        else {
                printf("The number is zero.\n");
        }
}
printf("Guard 1: %d\n", (v == (int)v));
printf("Guard 2: %d\n", sqrt(v) == (int)sqrt(v));
}
}


