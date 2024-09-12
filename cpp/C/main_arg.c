#include<stdio.h>
int main (int argc, char **args) {
    int i;
    printf("number of args %d\n",argc);
    for (i = 0; i<argc;i++) {
        printf("%dth argument is %s\n",i,args[i]);
    }

    char *ptr = &args[1][1];
    printf("%p\n",ptr);
    printf("%c\n", *ptr);
}