#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <iomanip>

#include "big_int.hpp"


// Windows compilers don't define ssize_t
#if defined(_MSC_VER) || defined(__BORLANDC__) || defined(__DJGPP__) || defined(__WATCOMC__)
typedef long int ssize_t;
#endif

// Borland (or at least bcc32 ver 5.2) doesn't understand the std namespace
#if ! (( defined(__BORLANDC__) && __BORLANDC__ < 0x550 ) || defined(__WATCOMC__) )
using namespace std;
#endif

/*
 * creates Big_int with given size and value
 * Parameters:
 *   size           - size of integer expressed as number of 
 *                    normal unsigned int's
 *   initial_value  - initial value of Big_int as a normal unsigned int
 */
Big_int::Big_int( size_t   size,
                  unsigned initial_value )
  : size_(size)
{
  number_ = new unsigned[size_];
  ::memset(number_, 0, size_*sizeof(unsigned));
  number_[0] = initial_value;
}


/*
 * creates Big_int with given size and value
 * Parameters:
 *   size           - size of integer expressed as number of 
 *                    normal unsigned int's
 *   initial_value  - initial value of Big_int as a string holding
 *                    hexadecimal representation of value. (There must
 *                    no other characters in string, including whitespace!)
 * Note:
 *  This code assumes that sizeof(unsigned) == 4!
 */
Big_int::Big_int( size_t size, const char * initial_value)
  : size_(size)
{
  size_t len = ::strlen(initial_value);
  number_ = new unsigned[size];
  int i;

  /*
   * Start at end of string and convert each 8 chars into a 4-byte
   * unsigned int.
   */
  int str_pos = (len > 8) ? len - 8 : 0;
  for( i=0; i < static_cast<ssize_t>(size) && str_pos >= 0; i++,str_pos -= 8 ){
    int status = sscanf(initial_value + str_pos, "%8x", &number_[i]);
    if ( status != 1 ) {
      delete [] number_;
      throw Bad_initial_value();
    }
  }
  /*
   * if array is full, but more chars left in string, throw overflow
   */
  if ( str_pos >= 0 )
    throw Overflow();
  
  /*
   * if any last chars left over, process them
   */
  if ( str_pos != -8 ) {
    char format[5];
    /*
     * create a custom sscanf format to read just the chars wanted
     */
    sprintf(format, "%%%dx", -str_pos );
    int status = sscanf(initial_value, format, &number_[i]);
    if ( status != 1 ) {
      delete [] number_;
      throw Bad_initial_value();
    }
    i++;
  }

  /*
   * zero out any remaining double words in number
   */
  for( ; i < static_cast<ssize_t>(size); i++ ) 
    number_[i] = 0;
}

/*
 * copy constructor
 * Parameter:
 *   bigi - Big_int to copy
 */
Big_int::Big_int( const Big_int & bigi )
  : size_(bigi.size_)
{
  number_ = new unsigned[size_];
  ::memcpy(number_, bigi.number_, sizeof(unsigned)*size_);
}

/*
 * Equals operator method
 * Parameter:
 *   bigi - Big_int to copy
 * Return value:
 *   reference to *this* Big_int
 */
const Big_int & Big_int::operator = ( const Big_int & bigi )
{
  if ( this != & bigi ) {
    if ( bigi.size_ != size_ ) {
      size_ = bigi.size_;
      delete [] number_;
      number_ = new unsigned[size_];
    }
    ::memcpy(number_, bigi.number_, sizeof(unsigned)*size_);
  }
  return *this;
}

/*
 * friend comparison operator
 * Parameters:
 *   op1 - first number to compare
 *   op2 - second number to compare
 * Return value:
 *   true if op1 == op2, else false
 */
bool operator == ( const Big_int & op1,
                   const Big_int & op2)
{
  int s1 = op1.size_;
  int s2 = op2.size_;

  if ( s1 == s2 )
    return ::memcmp( op1.number_, op2.number_, sizeof(unsigned) * s1) == 0;
  else
    throw Big_int::Size_mismatch();
}                                            

/*
 * friend comparison operator
 * Parameters:
 *   op1 - first number to compare
 *   op2 - second number to compare
 * Return value:
 *   true if op1 < op2, else false
 */
bool operator < ( const Big_int & op1,
                  const Big_int & op2 )
{
  int s1 = op1.size_;
  int s2 = op2.size_;

  if ( s1 == s2 ) {
    for( int i = s1-1; i >= 0; i-- )
      if ( op1.number_[i] < op2.number_[i] )
        return true;
      else if ( op1.number_[i] > op2.number_[i] )
        return false;
    return false;
  }
  else
    throw Big_int::Size_mismatch();
}
  

/*
 * friend output operator
 * Parameters:
 *   os   - output stream to write to
 *   bigi - Big_int to print value of
 * Return value:
 *   reference to os
 */
ostream & operator << ( ostream &       os,
                        const Big_int & bigi )
{
  ios::fmtflags oldflags = os.setf( ios::hex, ios::basefield);
  char old_fill = os.fill('0');
  bool leading_zero = true;

  for( int i = bigi.size_ - 1; i >= 0; i-- ) {
    if ( ! leading_zero )
      os.width(8);

    if ( bigi.number_[i] != 0)
      leading_zero = false;
    else if (i != 0 && leading_zero)
      continue;

    os << bigi.number_[i];
  }

  os.fill(old_fill);
  os.setf( oldflags, ios::basefield);

  return os;
}
