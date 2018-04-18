#include <stdio.h>

extern void inImage();
//extern void outImage();
extern char getChar();
extern void setInPos(int pos);
extern int getInPos();
extern int getText(char* buf, int size);

int main()
{
    inImage();

    char buf[5];
    int n = getText(buf, 3);

    printf("n: %d\n", n);
    printf("buf: %s", buf);

    /*
    char c = getChar();
    char s[1];
    s[0] = c;
    printf(", %s", s);
    
    c = getChar();
    s[0] = c;
    printf(", %s", s);

    c = getChar();
    s[0] = c;
    printf(", %s", s);
    */
    //outImage();
    printf("\n");
    return 0;
}