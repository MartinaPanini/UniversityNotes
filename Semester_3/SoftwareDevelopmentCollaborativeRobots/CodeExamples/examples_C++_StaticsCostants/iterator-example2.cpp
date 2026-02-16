#include <iostream>
#include <vector>

using namespace std;

void print(const vector<int> &v) {
    vector<int>::const_iterator i = begin(v);
    cout << "{";
    if (i!=end(v)) cout << *i;
    i++;
    for (;i!=end(v); i++) cout << ", " << *i;
    cout << "}" << endl;
}

int main()
{
    vector<int> v1 = {1,3,5,7,11,13,17,19};
    // copying the first 4 elements 
    vector<int> v2(v1.begin(), v1.begin()+4);

    // printing the two vectors
    print(v1);
    print(v2);

    int a[10] = {0,2,4,6,8,10,12,14,16,18};
    // copying elements from 2 to 5 included
    vector<int> v3(a+2, a+6);
    print(v3);

    // reverse copying
    vector<int> v4(v1.rbegin(), v1.rend());
    print(v4);

    // normal copying using the copy() function
    copy(v1.begin(), v1.end(), v4.begin());
    print(v4);

    // A string is a container of characters
    string name_sur("Giuseppe Lipari");
    string name(name_sur.begin(), name_sur.begin()+8);
    string surname(name_sur.begin()+9, name_sur.end());
    cout << name << endl;
    cout << surname << endl;
}
