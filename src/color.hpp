#ifndef _COLOR_HPP_
#define _COLOR_HPP_

class Color
{
public:
  unsigned int r;
  unsigned int g;
  unsigned int b;
  unsigned int a;
  Color() : r(0), g(0), b(0), a(0) { }
  ~Color() { }
};

#endif //_COLOR_HPP_
