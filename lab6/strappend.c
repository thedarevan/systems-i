#include <stdio.h>
void strappend(char arr[], char str[])
{
    int i = 0;
    int a = 0;

    while (arr[a] != '\0')
    {
        a++;
    }

    while (str[i] != '\0')
    {
        arr[a] = str[i];
        a++;
        i++;
    }

    arr[a] = '\0';
}
int main()

{

        char A[100] = "From start ";

        strappend(A, "to finish.");

        printf("%s\n", A);

        return 0;

}
