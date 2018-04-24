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

int main()
{
   
    putText("Essay 1:a ...");
    
    printf("\n##############################################\n");
    int t = getOutPos();
      printf("\n##############################################\n");
    printf("pos: %d\n", t);
    
    for(int i = 0; i < 100; i++)
    {
        putText("bajs");
    }
    printf("\n##############################################\n");
    outImage();

    t = getOutPos();
    printf("pos: %d\n", t);

    printf("\n");
    return 0;
}