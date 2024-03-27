#include <SDL2/SDL.h>
#include <stdio.h>

#include <sqlite3.h>

#include <mruby.hpp>

class Window
{

public:
  std::string title;
  int width, height;

  Window(int width, int height) : width(width), height(height)
  {
  }

  void run()
  {
    SDL_Window * window;
    SDL_Surface* screenSurface;
    window = SDL_CreateWindow(
            title.c_str(),
            SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
            width, height,
            SDL_WINDOW_SHOWN
            );

    screenSurface = SDL_GetWindowSurface(window);

    bool quit = false;
    SDL_Event event;

    while (!quit) {
      while (SDL_PollEvent(&event)) {
        if (event.type == SDL_QUIT) {
          quit = true;
        };
      }
      SDL_FillRect(screenSurface, NULL, SDL_MapRGB(screenSurface->format, 0xff, 0x00, 0xf0));
      SDL_UpdateWindowSurface(window);
    }

    SDL_DestroyWindow(window);
  }

  ~Window()
  {
  }

private:
};

// sets up the VM for use
void bind_classes(mruby::VM vm)
{
  auto cls = vm.create_class<Window, int, int>("Window");
  cls->bind_instance_method("run", &Window::run);
  cls->bind_instance_variable("title", &Window::title);
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
