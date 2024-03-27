# makefile for SDL_mixer

REQUIRED_TARGETS:=$(REQUIRED_TARGETS) obj/sdl_mixer/lib/libSDL2_mixer.la
CLEAN_TARGETS:=$(CLEAN_TARGETS) clean_sdl_mixer

INCLUDE_FLAGS:=$(INCLUDE_FLAGS) -Iobj/sdl_mixer/include
LIBRARY_FLAGS:=$(LIBRARY_FLAGS) -Lobj/sdl_mixer/lib
LINKER_FLAGS:=$(LINKER_FLAGS) -lSDL2_mixer

obj/sdl_mixer:
	mkdir -p obj/sdl_mixer

obj/sdl_mixer/lib/libSDL2_mixer.la: obj/sdl_mixer obj/sdl/lib/libSDL2.la
	cd lib/SDL_mixer && \
	SDL2_CONFIG=$(PWD)/obj/sdl/bin/sdl2-config ./configure --prefix=$(PWD)/obj/sdl_mixer -q && \
	make clean && \
	make install -j6 && \
	./libtool --finish $(PWD)/obj/sdl_mixer/lib

clean_sdl_mixer:
	rm -rf obj/sdl_mixer

.PHONY: clean_sdl_mixer
