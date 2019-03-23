#include <stdio.h>
#include <stdlib.h>

void k_clrscr();
int convert_num_h(unsigned int num, char buf[]);
void convert_num (unsigned int num, char buf[]);


void main(void)
{
   unsigned char* vga = (unsigned char*) 0xb8000;
   vga[0] = 'X';
   vga[1] = 0x09;

   k_clrscr();
   char buf [100];
   int n, i = 3, count, c;
  
   n = 20;

    printf("2\n");

   for (count = 2; count <= n ; )
     {
        for (c = 2; c <= i-1; c++ )
          {
            if ( i%c == 0)
               break;
          }
         if (c == i)
          {
            convert_num(i, buf);
            printf("%d\n", i);
            count++;
          }
          i++;
       }
   

   for(;;);        //make sure kernel never stops w/ infinite loop
}

void k_clrscr()
{
   printf("\033c");
}

int convert_num_h(unsigned int num, char buf[])
{
   if (num == 0)
      { return 0; }
   int idx = convert_num_h(num/10, buf);
   buf[idx] = num % 10 + '0';
   buf [idx + 1] = '\0';
   return idx + 1;
}

void convert_num (unsigned int num, char buf[])
{
  if (num == 0)
     { 
       buf [0] = '0';
       buf [1] = '\0';
     }
   else 
     {
        convert_num_h(num, buf);
     }
}
