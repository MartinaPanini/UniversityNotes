#include <iostream>
#include <vector>

using namespace std;

int main()
{
    int a[4] = {2, 4, 6, 8};
    vector<int> v = {2, 4, 6, 8};

    // visit the container with indexes
    for (int i=0; i<4; i++) cout << a[i];
    cout << endl;
    for (int i=0; i<4; i++) cout << v[i];
    cout << endl;
    
    // visit the container with pointers/iterators
    for (int *p=a; p!=&a[4]; p++) cout << *p;
    cout << endl;
    for (vector<int>::iterator q=v.begin(); q != v.end(); q++) cout << *q;
    cout << endl;

    vector<int>::iterator q = v.end();
    do {
        q--; cout << *q;
    } while (q != v.begin());
    cout << endl;
    
}
