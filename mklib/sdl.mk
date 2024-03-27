# makefile for SDL

REQUIRED_TARGETS:=$(REQUIRED_TARGETS) obj/sdl/lib/libSDL2.la
CLEAN_TARGETS:=$(CLEAN_TARGETS) clean_sdl

INCLUDE_FLAGS:=$(INCLUDE_FLAGS) -Iobj/sdl/include
LIBRARY_FLAGS:=$(LIBRARY_FLAGS) -Lobj/sdl/lib
LINKER_FLAGS:=$(LINKER_FLAGS) -lSDL2

obj/sdl:
	mkdir -p obj/sdl

obj/sdl/lib/libSDL2.la: obj/sdl
	@cd lib/SDL && \
	./configure --prefix=$(PWD)/obj/sdl -q && \
	make clean && \
	make install && \
	./libtool --finish $(PWD)/obj/sdl/lib

clean_sdl:
	rm -rf obj/sdl

.PHONY: clean_sdl
