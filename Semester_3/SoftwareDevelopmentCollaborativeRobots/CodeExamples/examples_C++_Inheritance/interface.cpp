class Cloneable {
public:
    virtual Cloneable * clone() = 0;
};

class Base {
protected:
    int anotherData;
public:
    Base(int ii): anotherData(ii) {}
    int get() { return anotherData; }
};

class MyClass : public Base, public Cloneable {
    int data;
public:
    MyClass(int ii) : data(ii) {} 
    MyClass *clone() { ... }
};



