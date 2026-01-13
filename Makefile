CC = x86_64-linux-musl-gcc
CXX = x86_64-linux-musl-g++
LD = x86_64-linux-musl-ld
STRIP = x86_64-linux-musl-strip
SHELL = bash

CFLAGS = -Wall -Werror -Wno-char-subscripts -static -fPIC
STRIPFLAGS = --strip-all
LDFLAGS = -L/opt/toolchains/x86_64-linux-musl-native/lib -static -fPIE
INCLUDES = -Idtc-aosp/libfdt -I/opt/toolchains/x86_64-linux-musl-native/include
MKDTIMG_SRC = libufdt/mkdtimg.c \
              libufdt/mkdtimg_cfg_create.c \
              libufdt/mkdtimg_core.c \
              libufdt/mkdtimg_create.c \
              libufdt/mkdtimg_dump.c \
              libufdt/dt_table.c \
			  libufdt/libufdt_sysdeps_posix.c
MKDTIMG_OBJ := $(patsubst %.c, obj/%.o, $(MKDTIMG_SRC))

.PHONY: all

all: mkdtimg

obj/%.o: %.c
	@mkdir -p `dirname $@`
	@echo -e "\t    CC\t    $@"
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

dtc-aosp/libfdt/libfdt.a:
	$(MAKE) -C dtc-aosp CC=$(CC) CXX=$(CXX) libfdt

mkdtimg: $(MKDTIMG_OBJ) dtc-aosp/libfdt/libfdt.a
	$(CC) $(INCLUDES) -o $@ $^ $(LDFLAGS)
	$(STRIP) $(STRIPFLAGS) $@

clean:
	@rm -rf obj mkdtimg
	@$(MAKE) -C dtc-aosp clean
