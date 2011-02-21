# Copyright 2003 Samuel Mimram
# libssl bindings for OCaml.
#
# by Samuel Mimram

# $Id: Makefile.in 6632 2009-06-17 12:22:14Z metamorph68 $


export OCAMLMAKEFILE = OCamlMakefile

export OCAMLFIND = /home/pad/packages/Linux/bin/ocamlfind
export OCAMLFIND_LDCONF = 
export LATEX = /usr/bin/latex
export DVIPS = /usr/bin/dvips
export PS2PDF = /usr/bin/ps2pdf
export BEST = bcl ncl
export OCAMLLIBPATH = /home/pad/packages/Linux/stow/ocaml-3.12/lib/ocaml

#SOURCES = ssl_stubs.c ssl.mli ssl.ml ssl_threads.ml
export RES_CLIB_SUF = _stubs
export RESULT = ssl
export LIBINSTALL_FILES = $(wildcard *.mli *.cmi *.cma *.cmxa *.cmx *.a *.so)
export OCAMLLDFLAGS =
export OCAMLDOCFLAGS = -stars
export CLIBS = crypto ssl
export CC = gcc
export CFLAGS = -g -O2 -ansi -DCAML_NAME_SPACE -Wall
export CPPFLAGS = 
export NO_CUSTOM = yes
OCAMLFLAGS = @OCAMLFLAGS@

define PROJ_ssl
  SOURCES = ssl_stubs.c ssl.mli ssl.ml
  RESULT = ssl
  THREADS = no
endef
export PROJ_ssl

define PROJ_sslthreads
  SOURCES = ssl_stubs.c ssl.mli ssl.ml ssl_threads.ml
  RESULT = ssl_threads
  THREADS = yes
endef
export PROJ_sslthreads

export SUBPROJS = ssl sslthreads

all: $(BEST)

byte: byte-code-library
opt: native-code-library

native-code-library: byte-code-library

install:
	$(OCAMLFIND) install $(OCAMLFIND_INSTFLAGS) $(RESULT) META $(LIBINSTALL_FILES)

uninstall:
	$(OCAMLFIND) remove $(OCAMLFIND_INSTFLAGS) $(RESULT)

update: uninstall install

# Catch-all target will be applied to all subprojects automatically
%:
	@$(MAKE) -f $(OCAMLMAKEFILE) subprojs SUBTARGET=$@

#-include $(OCAMLMAKEFILE)
