#include "manyobj.h"
#include <iostream>

#define PRINT(x) cout << x << ") How many: " << ManyObj::howMany() << "\n"

using namespace std;

void func(ManyObj obj)
{
  PRINT(0);
}

int main()
{
  ManyObj a;
  ManyObj *p1 = new ManyObj;
  ManyObj *p2 = 0;

  PRINT(1);

  {
    ManyObj b,c;

    PRINT(2);
    p2 = new ManyObj;

    PRINT(3);
  }
  
  PRINT(4);
   
  delete p1; delete p2;
  
  PRINT(5);

  func(a);
  
  PRINT(6);
}
