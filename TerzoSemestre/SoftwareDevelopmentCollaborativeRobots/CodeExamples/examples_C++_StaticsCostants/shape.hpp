#ifndef __SHAPE_H__
#define __SHAPE_H__

#include <iostream>

using namespace std;

#define TRACE(x) {cout << "executing " #x << endl; x;}
#define PR(x) cout << "    " #x << " = " << x << endl; 

class Shape {
protected:
    int xx,yy;
public:
    Shape(int x, int y);
    void move(int x, int y);

    virtual void draw() = 0;
    virtual void resize(int scale) = 0;
    virtual void rotate(int degree) = 0;
};

#endif
