# makefile for SQLite

REQUIRED_TARGETS:=$(REQUIRED_TARGETS) obj/sqlite/lib/libsqlite3.la
CLEAN_TARGETS:=$(CLEAN_TARGETS) clean_sqlite

INCLUDE_FLAGS:=$(INCLUDE_FLAGS) -Iobj/sqlite/include
LIBRARY_FLAGS:=$(LIBRARY_FLAGS) -Lobj/sqlite/lib
LINKER_FLAGS:=$(LINKER_FLAGS) -lsqlite3

obj/sqlite:
	mkdir -p obj/sqlite

obj/sqlite/lib/libsqlite3.la: obj/sqlite
	@cd lib/sqlite && \
	./configure --prefix=$(PWD)/obj/sqlite --disable-tcl -q && \
	make clean && \
	make install -j6

clean_sqlite:
	rm -rf obj/sqlite

.PHONY: clean_sqlite
