INCDIRS:=
LIBDIRS:=

REQUIRED_TARGETS:=
CLEAN_TARGETS:=

INCLUDE_FLAGS:=
LIBRARY_FLAGS:=
LINKER_FLAGS:=

SOURCES:=$(shell find src -type f -name '*.cpp')
OBJECTS:=$(patsubst src/%.cpp,obj/%.o,$(SOURCES))

CPPFLAGS:=-Wall -Werror -Wpedantic -g
CPP:=g++

CC:=$(CPP) $(CPPFLAGS)

all: bin/alcyone

run: bin/alcyone
	cd bin && ./alcyone

bin:
	mkdir -p bin

obj:
	mkdir -p obj

include mklib/*.mk

bin/alcyone: bin $(OBJECTS) $(REQUIRED_TARGETS)
	$(CC) $(OBJECTS) -o $@ $(INCLUDE_FLAGS) $(LIBRARY_FLAGS) $(LINKER_FLAGS)

# pull in dependency info for *existing* .o files
-include $(OBJECTS:.o=.d)

obj/%.o: src/%.cpp $(REQUIRED_TARGETS)
	@mkdir -p obj
	$(CC) -c $(INCLUDE_FLAGS) $< -o $@
	@# generate dependency info that can be used next time
	@$(CPP) -MM -MT $@ $(INCLUDE_FLAGS) $< > obj/$*.d
	@mv -f obj/$*.d obj/$*.d.tmp
	@sed -e 's/.*://' -e 's/\\$$//' < obj/$*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> obj/$*.d
	@rm -f obj/$*.d.tmp

clean: $(CLEAN_TARGETS)
	rm -rf bin
	rm -rf obj

.PHONY: clean run