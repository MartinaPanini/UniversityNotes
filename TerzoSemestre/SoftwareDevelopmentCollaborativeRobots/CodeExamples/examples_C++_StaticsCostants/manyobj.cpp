#include "manyobj.h"
#include <iostream>

using namespace std;

int ManyObj::count = 0;

ManyObj::ManyObj(const ManyObj &obj) : index(obj.index)
{
  count++;
  cout << "copy constructor called\n";
}

ManyObj::ManyObj()
{
  index = count++;
}

ManyObj::~ManyObj()
{
  cout << "destructor called\n";
  count--;
}

int ManyObj::getIndex()
{
  return index;
}

int ManyObj::howMany()
{
  return count;
}
