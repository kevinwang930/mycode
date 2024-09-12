#include<stdio.h>
#include<stdlib.h>

int main() {

    int * a ;
    a = malloc(sizeof(int) * 5);
    a[0]=5;
    a[1]=6;
    printf("%d\n",a[1]);
    printf("%d\n",*(a+1));
    free(a);
}

