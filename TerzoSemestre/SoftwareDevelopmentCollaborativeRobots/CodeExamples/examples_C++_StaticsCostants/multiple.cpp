#include <cstdlib>
#include <iostream>

using namespace std;

class A {
public:
  void f() { g(); }
  virtual void g() = 0;
};



class B : virtual public A {
public:
  void g() { cout << "B::g()\n"; }
};


class C : virtual public A {
public:
  void g() { cout << "C::g()\n"; }
};


class D : public B, public C {
public:
  void g() { cout << "D::g()\n"; }
  void h() {};
};


int main(int argc, char *argv[])
{
  D d;
  d.h();

  A *p = &d;

  p->f();
}



