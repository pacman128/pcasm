#ifndef BIG_INT_CLASS_HEADER
#define BIG_INT_CLASS_HEADER

#include <stdio.h>
#include <stdlib.h>
#include <iostream>

#include "cdecl.h"

#if (defined(__BORLANDC__) && __BORLANDC__ < 0x550) || defined(__WATCOMC__)
// Borland C++ (at least version bcc32 version 5.2 does not support the
// std namespace
#define std
#endif

/*
 * Big_int class
 * Instances of this class can represent unsigned integers of arbitrary
 * size.
 */
class Big_int {
public:
  /*********************
   * Exception classes *
   *********************/

  /*
   * Thrown if an addition overflows or subtraction underflows
   */
  class Overflow { };

  /*
   * Thrown if Big_ints of different sizes are added, subtracted or
   * compared
   */
  class Size_mismatch { };

  /*
   * Thrown if initialization fails
   */
  class Bad_initial_value { };

  /****************
   * Constructors *
   ****************/

  /*
   * creates Big_int with given size and value
   * Parameters:
   *   size           - size of integer expressed as number of 
   *                    normal unsigned int's
   *   initial_value  - initial value of Big_int as a normal unsigned int
   */
  explicit Big_int( size_t   size,
                    unsigned initial_value = 0);

  /*
   * creates Big_int with given size and value
   * Parameters:
   *   size           - size of integer expressed as number of 
   *                    normal unsigned int's
   *   initial_value  - initial value of Big_int as a string holding
   *                    hexadecimal representation of value. (There must
   *                    no other characters in string, including whitespace!)
   */
  Big_int( size_t       size,
           const char * initial_value);

  /*
   * copy constructor
   * Parameter:
   *   big_int_to_copy - Big_int to copy
   */
  Big_int( const Big_int & big_int_to_copy);

  /*
   * Destructor
   */
  ~Big_int();

  /*
   * size method
   * returns size of Big_int (in terms of unsigned int's)
   */
  size_t size() const;

  /*
   * Equals operator method
   * Parameter:
   *   big_int_to_copy - Big_int to copy
   * Return value:
   *   reference to *this* Big_int
   */
  const Big_int & operator = ( const Big_int & big_int_to_copy);


  /********************
   * Friend functions *
   ********************/

  /*
   * friend plus operator function
   * Adds two Big_int's of same size together. The result is the
   * same size as the operands.
   * Parameters:
   *   op1 - first number to add
   *   op2 - second number to add
   * Return value:
   *   new Big_int that is equal to op1 + op2
   */
  friend Big_int operator + ( const Big_int & op1,
                              const Big_int & op2 );

  /*
   * friend subtraction operator function
   * Subtracts one Big_int from another (They must have the same size.) 
   * The result is the same size as the operands.
   * Parameters:
   *   op1 - number to subtract from
   *   op2 - number to subtract
   * Return value:
   *   new Big_int that is equal to op1 - op2
   */
  friend Big_int operator - ( const Big_int & op1,
                              const Big_int & op2);

  /*
   * friend comparison operator
   * Parameters:
   *   op1 - first number to compare
   *   op2 - second number to compare
   * Return value:
   *   true if op1 == op2, else false
   */
  friend bool operator == ( const Big_int & op1,
                            const Big_int & op2 );

  /*
   * friend comparison operator
   * Parameters:
   *   op1 - first number to compare
   *   op2 - second number to compare
   * Return value:
   *   true if op1 < op2, else false
   */
  friend bool operator < ( const Big_int & op1,
                           const Big_int & op2);

  /*
   * friend output operator
   * Parameters:
   *   os - output stream to write to
   *   op - Big_int to print value of
   * Return value:
   *   reference to os
   */
  friend std::ostream & operator << ( std::ostream &  os,
                                      const Big_int & op );
private:

  /****************
   * Private data *
   ****************/

  /*
   * size of unsigned array
   */
  size_t      size_;

  /*
   * pointer to unsigned array holding Big_int value
   */
  unsigned * number_;
};


/************************************
 * Prototypes for assembly routines *
 ************************************/
extern "C" {
  int PRE_CDECL add_big_ints( Big_int &, const Big_int &, const Big_int &) POST_CDECL;
  int PRE_CDECL sub_big_ints( Big_int &, const Big_int &, const Big_int &) POST_CDECL; 
}

/********************************
 * Inline methods and functions *
 ********************************/

/*
 * size method
 * returns size of Big_int (in terms of unsigned int's)
 */
inline size_t Big_int::size() const
{
  return size_;
}

/*
 * Destructor
 */
inline Big_int::~Big_int()
{
  delete [] number_;
}

/*
 * friend plus operator function
 * Adds two Big_int's of same size together. The result is the
 * same size as the operands.
 * Parameters:
 *   op1 - first number to add
 *   op2 - second number to add
 * Return value:
 *   new Big_int that is equal to op1 + op2
 */
inline Big_int operator + ( const Big_int & op1, const Big_int & op2)
{
  Big_int result(op1.size());
  int res = add_big_ints(result, op1, op2);
  if (res == 1)
    throw Big_int::Overflow();
  if (res == 2)
    throw Big_int::Size_mismatch();
  return result;
}

/*
 * friend subtraction operator function
 * Subtracts one Big_int from another (They must have the same size.) 
 * The result is the same size as the operands.
 * Parameters:
 *   op1 - number to subtract from
 *   op2 - number to subtract
 * Return value:
 *   new Big_int that is equal to op1 - op2
 */
inline Big_int operator - ( const Big_int & op1, const Big_int & op2)
{
  Big_int result(op1.size());
  int res = sub_big_ints(result, op1, op2);
  if (res == 1)
    throw Big_int::Overflow();
  if (res == 2)
    throw Big_int::Size_mismatch();
  return result;
}

/**************************************************
 * Other inline comparison operators              *
 * (They use the friend comparision operators)    *
 **************************************************/


/*
 * comparison operator
 * Parameters:
 *   op1 - first number to compare
 *   op2 - second number to compare
 * Return value:
 *   true if op1 != op2, else false
 */
inline bool operator != ( const Big_int & op1, const Big_int &op2)
{
  return !(op1 == op2);
}

/*
 * comparison operator
 * Parameters:
 *   op1 - first number to compare
 *   op2 - second number to compare
 * Return value:
 *   true if op1 > op2, else false
 */
inline bool operator > ( const Big_int & op1, const Big_int & op2)
{
  return op2 < op1;
}

/*
 * comparison operator
 * Parameters:
 *   op1 - first number to compare
 *   op2 - second number to compare
 * Return value:
 *   true if op1 <= op2, else false
 */
inline bool operator <= ( const Big_int & op1, const Big_int & op2 )
{
  return !(op2 < op1);
}

/*
 * comparison operator
 * Parameters:
 *   op1 - first number to compare
 *   op2 - second number to compare
 * Return value:
 *   true if op1 >= op2, else false
 */
inline bool operator >= ( const Big_int & op1, const Big_int & op2)
{
  return !(op1 < op2);
}


#endif
