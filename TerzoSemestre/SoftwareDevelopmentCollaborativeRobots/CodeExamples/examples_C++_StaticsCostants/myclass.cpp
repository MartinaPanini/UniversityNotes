#include "myclass.hpp"

MyClass::MyClass(int i) : a(i) 
{
   cout << "Constructor" << endl;
}

MyClass::MyClass(const MyClass &r) {
    cout << "Copy constructor" << endl;
    a = r.a; 
}

void MyClass::fun(int y) { a = y; }
int MyClass::get() const { return a; }


