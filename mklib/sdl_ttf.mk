# makefile for SDL_ttf

REQUIRED_TARGETS:=$(REQUIRED_TARGETS) obj/sdl_ttf/lib/libSDL2_ttf.la
CLEAN_TARGETS:=$(CLEAN_TARGETS) clean_sdl_ttf

INCLUDE_FLAGS:=$(INCLUDE_FLAGS) -Iobj/sdl_ttf/include
LIBRARY_FLAGS:=$(LIBRARY_FLAGS) -Lobj/sdl_ttf/lib
LINKER_FLAGS:=$(LINKER_FLAGS) -lSDL2_ttf

obj/sdl_ttf:
	mkdir -p obj/sdl_ttf

obj/sdl_ttf/lib/libSDL2_ttf.la: obj/sdl_ttf obj/sdl/lib/libSDL2.la
	cd lib/SDL_ttf && \
	SDL2_CONFIG=$(PWD)/obj/sdl/bin/sdl2-config ./configure --prefix=$(PWD)/obj/sdl_ttf -q && \
	make clean && \
	make install -j6 && \
	./libtool --finish $(PWD)/obj/sdl_ttf/lib

clean_sdl_ttf:
	rm -rf obj/sdl_ttf

.PHONY: clean_sdl_ttf
