CC         := sdcc
AS         := sdasz80
HEX2BIN    := hex2bin

SOURCEDIR  := src
BUILDDIR   := build
DEST       := dsk
 
C_FILES    := $(wildcard $(SOURCEDIR)/*.c)
ASM_FILES  := $(wildcard $(BUILDDIR)/*.s)
REL_FILES  := $(patsubst $(BUILDDIR)/%.s,$(BUILDDIR)/%.rel,$(ASM_FILES))
IHX_FILES  := $(patsubst $(SOURCEDIR)/%.c,$(BUILDDIR)/%.ihx,$(C_FILES))
COM_FILES  := $(patsubst $(BUILDDIR)/%.ihx,$(BUILDDIR)/%.com,$(IHX_FILES))

INCLUDEDIR := /usr/local/fusion-c/include
LIBDIR     := /usr/local/fusion-c/lib
HEADERDIR  := /usr/local/fusion-c/header

# use this crt0 if you want to pass parameters to your program
# crt0 := $(INCLUDEDIR)crt0_msxdos_advanced.rel

ALL_INCLUDES := $(INCLUDEDIR)/crt0_msxdos.rel $(INCLUDEDIR)/printf.rel

# Standard Code-loc adress
ADDR_CODE := 0x106
# use this parameter if you are using crt0_msxdos_advanced
#ADDR_CODE := 0x180 
ADDR_DATA := 0x0

CCFLAGS := -mz80 --std-sdcc99 --max-allocs-per-node 50000 $\
    --no-std-crt0 --opt-code-size --disable-warning 196 $\
    --code-loc $(ADDR_CODE) --data-loc $(ADDR_DATA) $\
    -I $(HEADERDIR) fusion.lib -L $(LIBDIR) $(ALL_INCLUDES)


all: $(COM_FILES)

$(BUILDDIR)/%.ihx: $(SOURCEDIR)/%.c $(BUILDDIR)
	$(CC) $(CCFLAGS) $< -o $@

$(BUILDDIR)/%.com: $(BUILDDIR)/%.ihx $(BUILDDIR)
	hex2bin -e com $< 
	cp $(BUILDDIR)/*.com $(DEST)

$(BUILDDIR):
	mkdir -p $@

clean:
	rm -rf $(BUILDDIR)

.PHONY: all, clean, fclean, emulator, re
