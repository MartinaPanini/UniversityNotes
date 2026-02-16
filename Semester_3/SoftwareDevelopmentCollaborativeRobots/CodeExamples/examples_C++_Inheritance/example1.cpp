#include <iostream>

using namespace std;

class A {
private:
    int i;
protected:
    int j;
public:
    A() : i(0), j(0) {
        cout << "A()" << endl;
    }
    ~A() {
        cout << "~A()" << endl;
    }
    int get() const {
        return i;
    }
    void set(int x, int y) {
        i = x;
        j = y;
    }
    int f() const {
        return j;
    }
};

class B : public A {
    int i;
public:
    B() : A(), i(0) {
        cout << "B()" << endl;
    }
    ~B() {
        cout << "~B()" << endl;
    }
    void set(int a) {
        j = a; 
        i += j;
    }
    int g() const {
        return i;
    }
};


int main()
{
    B b;
    cout << b.get() << endl; 
    b.set(10);
    cout << b.g() << endl;
    b.g();

    A *a = &b;  
    a->f();
    //B *p = new A; // error

    A *p2 = new B; // ok

    delete p2;
}
