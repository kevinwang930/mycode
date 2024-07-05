#include<stdio.h>

int main() {

    unsigned int ui[] = {0u-1,15,3};

    unsigned int * ptr ;
    printf("unsigned int pointer dereference %u\n",*ui);
    ptr = &ui;
    ptr += 1;
    printf("unsigned int pointer shift %u\n", *ptr);
    printf("unsigned int pointer shift %u\n", *(((unsigned short *)ptr) + 2));
    unsigned short * sptr = ptr;
    printf("pointer diff %d\n",sptr-ui);
}