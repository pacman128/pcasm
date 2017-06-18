#include <stdio.h>

#include "cdecl.h"

double PRE_CDECL dmax( double, double ) POST_CDECL;

int main()
{
  double d1, d2;

  printf("Enter two doubles: ");
  scanf("%lf %lf", &d1, &d2);

  printf("The larger of %g and %g is %g\n", d1, d2, dmax(d1,d2));
  return 0;
}

