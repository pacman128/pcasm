#include <stdio.h>

/*
 * function bit_count
 * Counts the number of bits on (i.e., = 1) in an unsigned int
 * (This code assumes that an int is 32-bits!)
 * Parameter:
 *   x - number to count bits of
 * Return value:
 *   number of bits on in x
 */
int bit_count(unsigned int x )
{
  static unsigned int mask[] = { 0x55555555,
                                 0x33333333,
                                 0x0F0F0F0F,
                                 0x00FF00FF,
                                 0x0000FFFF };
  int i;
  int shift;   /* number of positions to shift to right */

  for( i=0, shift=1; i < 5; i++, shift *= 2 )
    x = (x & mask[i]) + ( (x >> shift) & mask[i] );
  return x;
}


int main()
{
  unsigned int x;

  printf("Enter a number: ");
  scanf("%i", &x);
  printf("There are %d bits on in %X\n", bit_count(x), x);
  return 0;
}
