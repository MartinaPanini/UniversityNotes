#include <iostream>

using namespace std;

class A {
    int a;
public:
    A(int x) : a(x) { 
        cout << "Constructor with a = " << a << endl; 
    }
    ~A() {
        cout << "Destructor with a = " << a << endl;
    }
};

A * myfun() 
{
    cout << "Inside myfun" << endl;
    A xx(1);
    A *p = new A(2);
    A yy(3);
    return p;
}

int main() 
{
    cout << "In the main" << endl;
    A obj1(0); 
    A *p = myfun();
    cout << "Again in the main" << endl;
    A obj2(4);
    //delete p; // comment / uncomment to see the difference
}

