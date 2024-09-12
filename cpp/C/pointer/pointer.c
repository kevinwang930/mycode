#include<stdio.h>
#include<stdlib.h>
struct books
{
    char title[50];
    char author[50];
    int book_id;
};

typedef struct books Book;

void print_n(int n)
{
    printf("print_n function %d\n", n);
}

void print_n1(int *n)
{
    printf("%d\n", *n);
    
}

void print_p(Book * b) {

    if (b != NULL) {
        printf("b is not null\n");
    }
}

int main() {
    int a;



    int *pointer_a;

    int* pointer_b;
    char * pc = "";
    if (pointer_a != NULL) {
        printf("pointer_a is not null\n");
    }
    struct books *bp;
    bp = (Book *)malloc(sizeof(Book));
    bp->book_id = 13;
    printf("book id is %d\n",bp->book_id);
    free(bp);

    void (*pointer_func)(int);

    void (*pointer_fun1)(int*);

    pointer_func = &print_n;
    pointer_fun1 = &print_n1;

    (*pointer_func)(5);

    pointer_a = &a;
    pointer_b = &a;

    a = 1;
    pointer_fun1(&a);
    *pointer_b = 10;
    printf("%d\n",*pointer_a);
    printf("%d",*pointer_b);

    Book b1;
    print_p(&b1);

    char c = NULL;
    char * np = &c;

    printf("size of void pointer %llu\n",sizeof(void *));
    printf("size of int pointer %llu\n", sizeof(int *));
    printf("size of char pointer %llu\n", sizeof(char *));
    printf("pointer address %p\n",pointer_b);
    if (*pc == '\0') 
        printf("null character pointer %c\n", *pc);
    printf("character pointer %p\n", pc);
    printf("null pointer address %p\n", np);
}