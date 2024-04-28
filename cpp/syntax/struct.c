#include <stdio.h>
#include <string.h>
#include<stddef.h>
#include<stdlib.h>
struct books {
    char title[50];
    char author[50];
    int book_id;
};

typedef struct books Book;

int main() {
    struct books book1;
    strcpy_s(book1.title,sizeof(book1.title),"book");
    printf("%s\n",book1.title);
    Book * bp = &book1;
    printf("%s\n",(*bp).title);
    printf("%s\n",bp->title);

    // Book * bp = (Book *)malloc(sizeof(Book));
    // free(bp);

    // printf("offsetof books title %llu\n",offsetof(struct books,author));

}
