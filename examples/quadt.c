/*
 * file: quadt.c
 * Test file for quad.asm
 */

#include <stdio.h>

#include "cdecl.h"

int PRE_CDECL quadratic( double, double, double, double *, double *) POST_CDECL;

int main()
{
  double a,b,c, root1, root2;

  printf("Enter a, b, c: ");
  scanf("%lf %lf %lf", &a, &b, &c);
  if (quadratic( a, b, c, &root1, &root2) )
    printf("roots: %.10g %.10g\n", root1, root2);
  else
    printf("No real roots\n");
  return 0;
}

