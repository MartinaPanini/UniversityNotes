#include "shape.hpp"
#include "circle.hpp"
#include "rect.hpp"
#include "triangle.hpp"

#include <stdio.h>
#include <stdlib.h>
#include <vector>

using namespace std;

int main(int argc, char *argv[])
{
  vector<Shape *> v;
  v.push_back(new Circle(1,1,4));
  v.push_back(new Rect(1,1,3,4));
  v.push_back(new Triangle(1,1,3,4));

  for (unsigned i = 0; i<v.size(); i++) v[i]->draw();

  for (unsigned i = 0; i<v.size(); i++) v[i]->move(i, i);
   
  // cout << "First Method: Fat Interface\n";
  // first method
  //for (i=0; i<3; ++i) v[i]->diagonal();

  // wrong way: this is a compiler error
  //Rect *r1 = v[1];

  // wrong way: this is a dangerous operation
  //Rect *r1 = static_cast<Rect *>(v[1]);
  //r1->diagonal();

  // cout << "Second Method: safe downcast\n";
  //second method
  // for (i=0; i<3; ++i) {
  //   Rect *r = dynamic_cast<Rect *>(v[i]);
  //   PR(r);
  //   if (r) r->diagonal();
  // }

  return 0;
}
