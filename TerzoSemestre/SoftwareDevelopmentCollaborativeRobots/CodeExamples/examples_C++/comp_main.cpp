#include <stdlib.h>
#include "complex.h"
#include <iostream>

using namespace std;

#define PR(x) cout << #x "=" << x << endl

int main()
{
  Complex c1;         // default constructor
  Complex c2(2);      // first constructor
  Complex c3(1,2);    // second constructor
  Complex c4(c3);     // copy constructor  

  //PR(c1);
  cout << "c1 = " << c1 << endl;
  
  c1 = c2;            // assignment
   
  PR(c1);
  cout << "c1 =" << c1 << endl;

  c2 = 3.0;           // WARNING!! implicit conversion!!  
  c3 += c2;           // operator +=

  c2 += 5;

  c4 = c1 + c3;

  PR(c2); PR(c3); PR(c4);
}
