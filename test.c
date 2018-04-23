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

    char buf[10] = "00000";
    int n = getText(buf, 10);

    printf("n: %d\n", n);
    printf("buf: %s\n", buf);

    buf[0] = getChar();
    buf[1] = '\0';
    printf("char after string: %s\n", buf);

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
    gegeg 78kjsdf
    //outImage();
    printf("\n");
    return 0;
}