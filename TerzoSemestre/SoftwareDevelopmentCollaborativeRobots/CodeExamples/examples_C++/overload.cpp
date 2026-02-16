#include <iostream>

class A {
public:
//    void f(int a, int b=0);
    void f(int a);
};

void A::f(int a) {
    std::cout << "Called f(int)" << std::endl;
}

//void A::f(int a, int b) {
//    std::cout << "Called f(int, int)" << std::endl;
//}

int main() {
    A a;
    a.f(5);
}
