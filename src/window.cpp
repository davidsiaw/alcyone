#include "window.hpp"

Window::Window(int width, int height) :
  width(width),
  height(height)
{
}

void Window::run()
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
    SDL_FillRect(screenSurface, NULL, SDL_MapRGB(screenSurface->format, r, g, b));
    SDL_UpdateWindowSurface(window);
  }

  SDL_DestroyWindow(window);
}

Window::~Window()
{
}
