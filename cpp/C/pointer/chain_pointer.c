#include<stdio.h>
#include<stdlib.h>
void testpointer(int **a) {
    int *b;
    b = malloc(sizeof(int));
    *b = 1;
    *a = b;
    
}
int main() {

    int *a;
    testpointer(&a);
    printf("value of a %d\n",*a);
    free(a);
}