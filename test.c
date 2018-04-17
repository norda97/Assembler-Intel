#include <stdio.h>

extern void inImage();
//extern void outImage();
extern char getChar();


int main()
{
    inImage();

    char c = getChar();
    char s[1];
    s[0] = c;
    printf("%s\n", s);

    c = getChar();
    s[0] = c;
    printf("%s\n", s);

    c = getChar();
    s[0] = c;
    printf("%s\n", s);

    //outImage();

    return 0;
}