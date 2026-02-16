/**
   file slicing.cpp

   This is an example of what is meant by object slicing. 
 */

//: C15:ObjectSlicing.cpp
#include <iostream>
#include <string>
using namespace std;

class Pet {
    string pname;
public:
    Pet(const string& name) : pname(name) {}
    virtual string name() const { return pname; }
    virtual string description() const {
        return "This is " + pname;
    }
};

class Dog : public Pet {
    string favoriteActivity;
public:
    Dog(const string& name, const string& activity)
        : Pet(name), favoriteActivity(activity) {}
    virtual string description() const {
        return Pet::name() + " likes to " +
            favoriteActivity;
    }
};

void describe(Pet p) { // Slices the object
    cout << p.description() << endl;
}

int main() {
    Pet p("Alfred");
    Dog d("Fluffy", "sleep");
    Pet *pd = &d;
 
    describe(p);
    describe(d);

    cout << pd->description() << endl;

} ///:~
