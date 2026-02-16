#include <iostream>
#include <vector>
#include <list>
#include <map>
#include <algorithm>

using namespace std;

template<class Iter>
void print(Iter begin, Iter end)
{
    Iter i = begin; 
    std::cout << "{";
    if (i!=end) cout << *i;
    i++;
    for (;i!=end; i++) cout << ", " << *i;
    cout << "}" << endl;        
}

bool mycmp(int a, int b)
{
    return a > b;
}

std::ostream &operator<<(std::ostream &os, const std::pair<string, int> &obj)
{
    os << "(" << obj.first << ", " << obj.second << ")";
    return os;
}

bool mycmp2(const std::pair<string, int> &a, const std::pair<string, int> &b) 
{
    return a.second > b.second;
}

int main()
{
    vector<int> v1 = {1,3,5,7,11,13,17,19};
    vector<string> v2 = {"Arezzo", "Firenze", "Grosseto", "Livorno", "Lucca", 
                         "Massa-Carrara", "Pisa", "Pistoia", "Siena"};  
    
    print(v1.begin(), v1.end());

    list<int> l1(v1.rbegin(), v1.rend());
    print(l1.begin(), l1.end());    
    
    copy(l1.begin(), l1.end(), v1.begin());
    print(v1.begin(), v1.end());

    sort(v1.begin(), v1.end()); // requires a random iterator
    print(v1.begin(), v1.end());
    
    sort(v1.begin(), v1.end(), mycmp);
    print(v1.begin(), v1.end());

    map<string, int> m; 
    
    int k = 0;
    for (vector<string>::iterator i=v2.begin(); i!=v2.end(); ++i)
        m[*i] = k++;

    print(m.begin(), m.end());

    cout << m["Pisa"] << endl;
    m["Siena"] = 10;
    m["Pisa"] = 11;
    m["Arezzo"] = 8;

    m["Roma"] = 100;
    m["Milano"] = 90;
    print(m.begin(), m.end());

    // vector<string> v4(m.begin(), m.end()); // cannot be done
    // sort(m.begin(), m.end());  // cannot be sorted

    // exercise  : copy from map to vector
    // exercise2 : use foreach!!
}
