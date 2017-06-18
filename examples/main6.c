/*
 * file: main6.c
 * main C program that uses assembly routine in sub5.asm
 * to create executable:
 * DJGPP:   gcc -o sub5 main5.c sub5.o
 * Borland: bcc32 sub5.obj main5.c
 */

#include <stdio.h>

#include "cdecl.h"

int PRE_CDECL calc_sum( int ) POST_CDECL;     /* prototype for assembly routine */

int main( void )
{
  int n, sum;

  printf("Sum integers up to: ");
  scanf("%d", &n);
  sum = calc_sum(n);
  printf("Sum is %d\n", sum);
  return 0;
}
