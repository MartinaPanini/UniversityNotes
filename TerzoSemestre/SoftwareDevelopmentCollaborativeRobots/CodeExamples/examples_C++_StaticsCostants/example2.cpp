#include <iostream>

using namespace std;

class Base {
public:
    virtual void f() 
    { cout << "Base f()" << endl; }
    void g() { 
        this->f(); 
        this->h(); 
    }
    void h() { cout << "Base h()" << endl; }
};

class Derived : public Base {
public:
    virtual void f() override
    { cout << "Derived f()"<< endl; }
    void g() { cout << "Derived g()" << endl; }
    void h() { cout << "Derived h()" << endl; }
};

int main()
{
    Derived *p = new Derived();
    
    p->g();
}




