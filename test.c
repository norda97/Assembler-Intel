#include <stdio.h>

extern void inImage();
extern void outImage();
extern char getChar();
extern void setInPos(int pos);
extern int getInPos();
extern void setOutPos(int pos);
extern int getOutPos();
extern int getText(char* buf, int size);
extern int getInt();
extern void putText(char* buf);
extern void putChar(char c);
extern void putInt(int i);

int main()
{
    inImage();
    char c[12];
    getText(c, 12);
    putText(c);

    outImage();
    return 0;
}