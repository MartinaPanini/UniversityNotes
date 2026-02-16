#include "circle.hpp"
#include "rect.hpp"
#include "triangle.hpp"

int main()
{
  Shape * shapes[3];

  shapes[0] = new Circle(1,1,4);
  shapes[1] = new Rect(2,2,5,6);
  shapes[2] = new Triangle(3,3,7,10);

  int i;

  for (i=0; i<3; ++i) TRACE(shapes[i]->draw());
  
  for (i=0; i<3; ++i) TRACE(shapes[i]->move(1,1));
  
  for (i=0; i<3; ++i) TRACE(shapes[i]->resize(2));
  
  for (i=0; i<3; ++i) TRACE(shapes[i]->rotate(1));
}

