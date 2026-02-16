/**
  file complex.h

  This file contains the first example of implementation of 
  a class in C++. It demonstrates the use of operator overloading,
  copy constructors, assignment operators.
*/

#include <iostream>

class Complex {
  double real_;
  double imaginary_;

  friend std::ostream &operator<<(std::ostream& o, const Complex &a);

 public:
  Complex();
  Complex(double a);
  Complex(double a, double b);
  
  Complex(const Complex &a);
  ~Complex();

  // member functions
  
  double real() const;
  double imaginary() const;
  double module() const;

  // operators
  Complex &operator=(const Complex &a);
  
  Complex &operator+=(const Complex &a);
  Complex &operator-=(const Complex &a);

  const Complex& operator++();            // prefix   ++a;
  const Complex  operator++(int);         // postix   a++;
  const Complex& operator--();            // prefix
  const Complex  operator--(int);         // postix
};

// global operators
const Complex operator+(const Complex &a, const Complex &b);
std::ostream &operator<<(std::ostream& o, const Complex &a);



















