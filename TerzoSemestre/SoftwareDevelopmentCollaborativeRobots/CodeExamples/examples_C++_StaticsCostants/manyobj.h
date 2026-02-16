/**
   file manyobj.h

   In this example we show the use of the keyword static in C++ for
   static class members.
 */
class ManyObj {
  static int count;
  int index;
 public:
  ManyObj();
  ~ManyObj();
  ManyObj(const ManyObj &);
  
  static int howMany();
  
  int getIndex();
};
