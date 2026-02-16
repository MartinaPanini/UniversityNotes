#include "complex.h"
#include "math.h"

Complex::Complex() : real_(0), imaginary_(0)
{}

Complex::Complex(double a) : real_(a), imaginary_(0)
{}

Complex::Complex(double a, double b) : real_(a), imaginary_(b)
{}

Complex::Complex(const Complex &a) : real_(a.real_), imaginary_(a.imaginary_)
{}

Complex::~Complex() {}

double Complex::real() const
{
  return real_;
}

double Complex::imaginary() const
{
  return imaginary_;
}

double Complex::module() const
{
  return sqrt(real_ * real_ + imaginary_ * imaginary_);
}

Complex& Complex::operator=(const Complex &a)
{
  real_ = a.real_;
  imaginary_ = a.imaginary_;
  return *this;
}

Complex& Complex::operator+=(const Complex &a)
{
  real_ += a.real_;
  imaginary_ += a.imaginary_;
  return *this;
}

Complex& Complex::operator-=(const Complex &a)
{
  real_ -= a.real_;
  imaginary_ -= a.imaginary_;
  return *this;
}

// void Complex::operator++()
const Complex& Complex::operator++()           //     (++c1).real();
{                                              //     call ++ on c1;
  ++real_;                                    //     the result is the new c1
  return *this;                            //     invoke real() on this new c1
}

const Complex Complex::operator++(int)             //      (c1++).real();
{
  Complex t(*this);
  ++real_;
  return t;
}

const Complex& Complex::operator--()
{
  --real_;
  return *this;
}

const Complex Complex::operator--(int)
{
  Complex t(*this);
  --real_;
  return t;
}

const Complex operator+(const Complex &a, const Complex &b)
{
  //Complex t(a);
  //t+=b;
  //return t;

  return Complex(a.real() + b.real(), a.imaginary() + b.imaginary());
}


std::ostream& operator<<(std::ostream &o, const Complex &a)
{
  o << "{" << a.real_ << "," << a.imaginary_ << "}";
  return o;
}



