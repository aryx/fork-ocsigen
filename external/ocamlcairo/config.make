
VERSION = 1.2.0

OCAMLC     = ocamlc.opt
OCAMLOPT   = ocamlopt.opt
OCAMLMKLIB = ocamlmklib
OCAMLLIB   = /home/pad/packages/Linux/stow/ocaml-3.12/lib/ocaml
OCAMLDOC   = ocamldoc
OCAMLDEP   = ocamldep

INSTALLDIR = $(OCAMLLIB)/cairo

LABLGTKDIR = 
C_LABLGTKDIR = $(subst +,$(OCAMLLIB)/,$(LABLGTKDIR))

# stop ocamlmklib moaning
FILT = -Wl,--export-dynamic

CAIRO_CFLAGS = -I/usr/include/cairo -I/usr/include/freetype2 -I/usr/include/libpng12  
CAIRO_LIBS   = $(filter-out $(FILT),-L/usr/lib -lcairo -lfreetype  )

GDK_CFLAGS = 
GDK_LIBS   = $(filter-out $(FILT),)

LIBSVG_CAIRO_CFLAGS = 
LIBSVG_CAIRO_LIBS   = 

cobjs     = $(patsubst %.c, %.o, $(filter %.c,$(1)))
mlintfs   = $(patsubst %.mli, %.cmi, $(filter %.mli,$(1)))
mlobjs    = $(patsubst %.ml, %.cmo, $(filter %.ml,$(1)))
mloptobjs = $(patsubst %.ml, %.cmx, $(filter %.ml,$(1)))
