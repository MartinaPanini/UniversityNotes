#include <iostream>
using namespace std;

class MyClass {
    int a;
//    MyClass(const MyClass &r);
public:
    MyClass(int i);
    MyClass(const MyClass &r); // make it private to show compiling errors
    void fun(int y);
    int get() const;
};
