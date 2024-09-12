#include<stdio.h>
int main() {

    int a = 1,b=1;
    if(a==1 && ((b=2) ==0) || a ==1)
        printf("or after and can be executed\n");
    
    printf("assign b to 2 during comparision, after that result of b %d\n",b);

    if((b=3)==3)
        printf("assign b to 3 before comparision now b is %d\n",b);
        
}