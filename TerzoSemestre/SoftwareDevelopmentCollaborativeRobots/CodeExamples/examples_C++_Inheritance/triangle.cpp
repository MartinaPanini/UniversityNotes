#include "triangle.hpp"


Triangle::Triangle(int x, int y, int a, int b) : Shape(x,y), aa(a), bb(b) {}

void Triangle::draw()
{
  cout << "Triangle::draw() called" << endl;
  PR(xx); PR(yy); PR(aa); PR(bb); 
}

void Triangle::resize(int scale)
{
  cout << "Triangle::resize() called" << endl;
  aa *= scale;
  bb *= scale;
  PR(xx); PR(yy); PR(aa); PR(bb);  
}

void Triangle::rotate(int degree)
{
  cout << "Triangle::rotate() called" << endl;
  PR(xx); PR(yy); PR(aa); PR(bb); 
}
