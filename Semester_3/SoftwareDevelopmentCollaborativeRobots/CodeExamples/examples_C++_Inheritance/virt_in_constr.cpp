#include <iostream>
#include <string>

using namespace std;

class Base {
    string name;
public:
    Base(const string &n) : name(n) {}
    virtual string getName() { return name; }
    virtual ~Base() { cout << "Destructor name is: " << getName() << endl;}
};

class Derived : public Base {
    string name2;
public:
    Derived(const string &n) : Base(n), name2(n + "2") {}
    virtual string getName() {return name2;}
    virtual ~Derived() {}
};


int main()
{
    Base *p = new Derived("Jack"); 

    cout << "In the main" << endl;
    cout << "My name is: " << p->getName() << endl;

    delete p;
}
