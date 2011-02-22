TOP=../
#############################################################################
# Configuration section
#############################################################################

include $(TOP)/Makefile.config

##############################################################################
# Variables
##############################################################################
TARGET=lib

SRC=ocsimoron.ml 

# when ocsigen is installed, can use package name instead of those -I
LIBSOCSIGEN=$(LIBDIRS1)
LIBS = -package lwt.unix,pcre $(LIBSOCSIGEN) -I $(TOP)/commons

##############################################################################
# Generic ocaml variables
##############################################################################

OCAMLC= $(OCAMLFIND) $(CAMLCNAME) $(DBG) $(LIBS)
OCAMLOPT= $(OCAMLFIND) $(CAMLOPTNAME) $(DBG) $(LIBS)
OCAMLDEP= $(OCAMLFIND) ocamldep

ifeq "$(NATDYNLINK)" "YES"
CMXS=$(FILES:.ml=.cmxs)
CMXSCMD=cp $(OBJSOPT) ..
else
CMXS=
CMXSCMD=
endif

##############################################################################
# Generic variables
##############################################################################

OBJS=$(SRC:.ml=.cmo)
OBJSOPT=$(CMXS)

##############################################################################
# Top rules
##############################################################################

all:: $(TARGET).cma

$(TARGET).cma: $(OBJS)
	$(OCAMLC) -a -o $(TARGET).cma $(OBJS)

##############################################################################
# Generic ocaml rules
##############################################################################

.SUFFIXES:
.SUFFIXES: .ml .mli .cmo .cmi .cmx .cmxs

.PHONY: doc

.ml.cmo:
	$(OCAMLC) -c $<

.mli.cmi:
	$(OCAMLC) -c $<

.ml.cmx:
	$(OCAMLOPT) -c $<

.cmx.cmxs:
	$(OCAMLOPT) -shared -linkall -o $@ $<

clean::
	-rm -f *.cm[ioxa] *.cmxa *.cmxs *.o *~ $(NAME)

depend:
	$(OCAMLDEP) $(PP) $(LIBS) $(SRC:.ml=.mli) $(SRC) > .depend

-include .depend
