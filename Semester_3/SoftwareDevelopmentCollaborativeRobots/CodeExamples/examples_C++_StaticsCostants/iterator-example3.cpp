#include <iostream>
#include <vector>
#include <list>

using namespace std;

template<class T>
void print(const vector<T>&v) 
{
    typename vector<T>::const_iterator i = v.begin();
    cout << "{";
    if (i!=v.end()) cout << *i;
    i++;
    for (;i!=v.end(); i++) cout << ", " << *i;
    cout << "}" << endl;
}

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

int main()
{
    vector<int> v1 = {1,3,5,7,11,13,17,19};
    vector<string> v2 = {"Arezzo", "Firenze", "Grosseto", "Livorno", "Lucca", 
                         "Massa-Carrara", "Pisa", "Pistoia", "Siena"};  
    
    print(v1);
    print(v2);

    print(v1.begin(), v1.begin()+4);
    print(v2.begin(), v2.begin()+4);

    list<int> l(v1.begin(), v1.end());

    print(l.begin(), l.end());
    
    string name_sur("Giuseppe Lipari");
    print(name_sur.begin(), name_sur.begin()+8);
}
