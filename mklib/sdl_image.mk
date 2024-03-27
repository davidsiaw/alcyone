# makefile for SDL_image

REQUIRED_TARGETS:=$(REQUIRED_TARGETS) obj/sdl_image/lib/libSDL2_image.la
CLEAN_TARGETS:=$(CLEAN_TARGETS) clean_sdl_image

INCLUDE_FLAGS:=$(INCLUDE_FLAGS) -Iobj/sdl_image/include
LIBRARY_FLAGS:=$(LIBRARY_FLAGS) -Lobj/sdl_image/lib
LINKER_FLAGS:=$(LINKER_FLAGS) -lSDL2_image

obj/sdl_image:
	mkdir -p obj/sdl_image

obj/sdl_image/lib/libSDL2_image.la: obj/sdl_image obj/sdl/lib/libSDL2.la
	cd lib/SDL_image && \
	SDL2_CONFIG=$(PWD)/obj/sdl/bin/sdl2-config ./configure --prefix=$(PWD)/obj/sdl_image -q && \
	make clean && \
	make install -j6 && \
	./libtool --finish $(PWD)/obj/sdl_image/lib

clean_sdl_image:
	rm -rf obj/sdl_image

.PHONY: clean_sdl_image
