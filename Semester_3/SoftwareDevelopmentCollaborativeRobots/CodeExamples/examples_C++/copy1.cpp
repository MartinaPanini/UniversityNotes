#include "myclass.hpp"

void g(MyClass c) {
    c.fun(5);
}

void h(MyClass &c) {
    c.fun(5);
    //c.get();
} 

int main() {
    MyClass obj(2);

    cout << "Before calling g: obj.get() = " << obj.get() << endl;
    g(obj);
    cout << "After calling g: obj.get() = " << obj.get() << endl;
    h(obj);
    cout << "After calling h: obj.get() = " << obj.get() << endl;    
}
