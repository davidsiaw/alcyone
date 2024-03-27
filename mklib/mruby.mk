# makefile for mruby and mruby-cpp

REQUIRED_TARGETS:=$(REQUIRED_TARGETS) obj/mruby/lib/libmruby.a
CLEAN_TARGETS:=$(CLEAN_TARGETS) clean_mruby

INCLUDE_FLAGS:=$(INCLUDE_FLAGS) -isystem obj/mruby/include
LIBRARY_FLAGS:=$(LIBRARY_FLAGS) -Lobj/mruby/lib
LINKER_FLAGS:=$(LINKER_FLAGS) -lmruby

obj/mruby:
	mkdir -p obj/mruby

obj/mruby/lib/libmruby.a: obj/mruby
	mkdir -p obj/mruby/lib
	mkdir -p obj/mruby/include
	@cd lib/mruby-cpp/mruby && \
	rake clean && \
	rake -j6 && \
	cp build/host/lib/libmruby.a $(PWD)/obj/mruby/lib && \
	cp -rf include $(PWD)/obj/mruby
	cp -f lib/mruby-cpp/*.hpp $(PWD)/obj/mruby/include


clean_mruby:
	rm -rf obj/mruby

.PHONY: clean_mruby
