#include <stdio.h>

static unsigned char byte_bit_count[256];  /* lookup table */

void initialize_count_bits()
{
  int cnt, i, data;

  for( i = 0; i < 256; i++ ) {
    cnt = 0;
    data = i;
    while( data != 0 ) {	
      data = data & (data - 1);
      cnt++;
    }
    byte_bit_count[i] = cnt;
    printf("%d %d\n", i, byte_bit_count[i]);
  }
}

int count_bits( unsigned int data )
{
  const unsigned char * dword = ( unsigned char *) & data;

  return byte_bit_count[dword[0]] + byte_bit_count[dword[1]] +
         byte_bit_count[dword[2]] + byte_bit_count[dword[3]];
}

int main()
{
  unsigned int x;

  initialize_count_bits();
  printf("Enter a number: ");
  scanf("%i", &x);
  printf("There are %d bits on in %X\n", count_bits(x), x);
  return 0;
}
