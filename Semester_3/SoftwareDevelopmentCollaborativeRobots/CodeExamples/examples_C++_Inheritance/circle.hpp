#ifndef __CIRCLE_H__
#define __CIRCLE_H__

#include "shape.hpp"

class Circle : public Shape {
  int rr;
 public:
  Circle(int x, int y, int r);
  void draw();
  virtual void resize(int scale);
  virtual void rotate(int degree);
};

#endif
