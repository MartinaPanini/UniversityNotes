/** Shows a shared subobject via a virtual base. */
#include <iostream>
using namespace std;
 
class Top {
protected:
    int x;
public:
    Top() : x(0) {}
    Top(int n) { x = n; }
    virtual ~Top() {}

    int getX() { return x; }

    friend ostream&
    operator<<(ostream& os, const Top& t) {
        return os << t.x;
    }
};
 
class Left : virtual public Top {
protected:
  int y;
public:
  Left(int m, int n) : Top(m) { y = n; }
};
 
class Right : virtual public Top {
protected:
  int z;
public:
  Right(int m, int n) : Top(m) { z = n; }
};
 
// 
class Bottom : public Left, public Right {
  int w;
public:
  Bottom(int i, int j, int k, int m)
  : Top(i), Left(25, k), Right(25, m) { w = m; }
  friend ostream&
  operator<<(ostream& os, const Bottom& b) {
    return os << b.x << ',' << b.y << ',' << b.z
      << ',' << b.w;
  }
};
 
int main() {
    Bottom b(1, 2, 3, 4);

    cout << b << endl;
    cout << b.getX() << endl;

//  cout << sizeof(b) << endl;
//  cout << static_cast<void*>(&b) << endl;
//  Top* p = static_cast<Top*>(&b);
//  cout << *p << endl;
//  cout << static_cast<void*>(p) << endl;
//  cout << dynamic_cast<void*>(p) << endl;
} ///:~

