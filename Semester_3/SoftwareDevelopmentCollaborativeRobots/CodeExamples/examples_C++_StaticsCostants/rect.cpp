#include "rect.hpp"

Rect::Rect(int x, int y, int a, int b) : Shape(x,y), aa(a), bb(b) {}

void Rect::draw()
{
  cout << "Rect::draw() called" << endl;
  PR(xx); PR(yy); PR(aa); PR(bb); 
}

void Rect::resize(int scale)
{
  cout << "Rect::resize() called" << endl;
  aa *= scale;
  bb *= scale;
  PR(xx); PR(yy); PR(aa); PR(bb);  
}

void Rect::rotate(int degree)
{
  cout << "Rect::rotate() called" << endl;
  PR(xx); PR(yy); PR(aa); PR(bb); 
}
