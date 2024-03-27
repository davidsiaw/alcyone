#include <stdio.h>

#include <sqlite3.h>

#include "window.hpp"

// sets up the VM for use
void bind_classes(mruby::VM vm)
{
  auto color_class = vm.create_class<Color>("Color");
  color_class->bind_instance_variable("r", &Color::r);
  color_class->bind_instance_variable("g", &Color::g);
  color_class->bind_instance_variable("b", &Color::b);
  color_class->bind_instance_variable("a", &Color::a);
  
  auto window_class = vm.create_class<Window, int, int>("Window");
  window_class->bind_instance_method("run", &Window::run);
  window_class->bind_instance_variable("title", &Window::title);
  window_class->bind_instance_variable("r", &Window::r);
  window_class->bind_instance_variable("g", &Window::g);
  window_class->bind_instance_variable("b", &Window::b);

}

int main(int argc, char* args[])
{
  // initialize various systems
  sqlite3_initialize();
  mruby::VM vm;

  if (SDL_Init(SDL_INIT_EVERYTHING) < 0) {
    fprintf(stderr, "could not initialize sdl2: %s\n", SDL_GetError());
    return 1;
  }

  // TODO: gather info about the system
  // TODO: fill in the blanks
  // TODO: prepare debug stuff

  // setup the VM
  bind_classes(vm);

  // start the script
  vm.run("eval File.read('main.rb')");

  // shutdown various systems
  SDL_Quit();
  sqlite3_shutdown();

  return 0;
}
