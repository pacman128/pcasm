/*
 * file: readt.c
 * This program tests the 32-bit read_doubles() assembly procedure.
 * It reads the doubles from stdin. 
 * (Use redirection to read from file.)
 */

#include <stdio.h>

#include "cdecl.h"

extern int PRE_CDECL read_doubles( FILE *, double *, int ) POST_CDECL;

#define MAX 100

int main()
{
  int i,n;
  double a[MAX];

  n = read_doubles(stdin, a, MAX);

  for( i=0; i < n; i++ )
    printf("%3d %g\n", i, a[i]);
  return 0;
}
