#include <iostream>
using namespace std;

class MyClass {
    int a;
public:
    MyClass(int i) { a = i; }
    void fun(int y) { a = y; }
    int get() { return a; }
};

void g(MyClass c) {
    c.fun(5);
}

void h(MyClass *p) {
    p->fun(5);
} 

int main() {
    MyClass obj(0);

    cout << "Before calling g: obj.get() = " << obj.get() << endl;
    g(obj);
    cout << "After calling g: obj.get() = " << obj.get() << endl;
    h(&obj);
    cout << "After calling h: obj.get() = " << obj.get() << endl;    
}
