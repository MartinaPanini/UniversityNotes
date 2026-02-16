#include "circle.hpp"

Circle::Circle(int x, int y, int r) : Shape(x,y), rr(r) {}

void Circle::draw()
{
  cout << "Circle::draw() called" << endl;
  PR(xx); PR(yy); PR(rr); 
}

void Circle::resize(int scale)
{
  cout << "Circle::resize() called" << endl;
  rr *= scale;
  PR(xx); PR(yy); PR(rr); 
}

void Circle::rotate(int degree)
{
  cout << "Circle::rotate() called" << endl;
  PR(xx); PR(yy); PR(rr); 
}
