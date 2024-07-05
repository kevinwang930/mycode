#include<stdio.h>
#include<math.h>
int main() {

    unsigned long a ;
    long b,neg;
    a = 0u-1;
    neg = -1;
    int i,j = 0;
    i = j++;
    unsigned int k = 0xffu;
    unsigned short us = 0u-1;
    unsigned int ui = (us << 16);
    short sn = 0xffffu;
    
    printf("size of unsigned int is %llu\n", sizeof(unsigned int));
    printf("size of unsigned long is %llu\n",sizeof(unsigned long));
    printf("size of long is %llu\n", sizeof(long));
    printf("size of long long is %llu\n", sizeof(long long));
    printf("unsigned long a %lu\n",a);
    printf("unsigned long change to short a %lu\n", (unsigned short)a);
    printf("%lu\n",(unsigned long)(pow(2,32) - 1));
    printf("%lu\n",a>>30);
 

    printf("%lu\n",neg);
    printf("%lu\n",(0u-(unsigned long)neg));
    printf("i after ++ is %d\n",i);
    printf("j after ++ is %d\n", j);
    printf("unsigned in 0xffu %d\n",k);
    printf("unsigned short %d\n", us);
    printf("unsigned int %lu\n", ui);
    printf("unsigned int change to short %d\n", (unsigned short)ui);

    printf("short 0xffffu is %d\n", sn);
}