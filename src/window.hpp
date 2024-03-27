#ifndef _WINDOW_HPP_
#define _WINDOW_HPP_

#include <string>

#include <SDL2/SDL.h>
#include <mruby.hpp>

#include "color.hpp"

class Window
{
public:
  std::string title;
  int width, height;
  int r, g, b;

  Window(int width, int height);
  void run();
  ~Window();
};

#endif //_WINDOW_HPP_
