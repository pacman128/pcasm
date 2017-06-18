/*
 * file: memex.c
 */

#include <stdio.h>

#include "cdecl.h"

#define STR_SIZE 30
/*
 * prototypes
 */

void PRE_CDECL asm_copy( void *, 
                         const void *,
                         unsigned ) POST_CDECL;

void * PRE_CDECL asm_find( const void *,
                           char target,
                           unsigned ) POST_CDECL;

unsigned PRE_CDECL asm_strlen( const char * ) POST_CDECL;

void PRE_CDECL asm_strcpy( char *,
                           const char * ) POST_CDECL;

int main()
{
  char st1[STR_SIZE] = "test string";
  char st2[STR_SIZE];
  char * st;
  char   ch;

  asm_copy(st2, st1, STR_SIZE);   /* copy all 30 chars of string */
  printf("%s\n", st2);

  printf("Enter a char: ");  /* look for byte in string */
  scanf("%c%*[^\n]", &ch);
  st = asm_find(st2, ch, STR_SIZE);
  if ( st )
    printf("Found it: %s\n", st);
  else
    printf("Not found\n");

  st1[0] = 0;
  printf("Enter string:");
  scanf("%s", st1);
  printf("len = %u\n", asm_strlen(st1));

  asm_strcpy( st2, st1);     /* copy meaningful data in string */
  printf("%s\n", st2 );

  return 0;
}

