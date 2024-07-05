#include<stdio.h>

int main() {

    unsigned long a = 1;
    unsigned long sum = a + (~a);
    unsigned long sum1 = sum + 1;

    printf("1 is %lu\n", a);
    printf("complement of 1 is %lu\n",~a);
    printf("sum of a number and its complement is %lu\n",sum);
    printf("%lu\n",sum1);
}