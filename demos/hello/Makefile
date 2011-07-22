#############################################################################
# Configuration section
#############################################################################

##############################################################################
# Variables
##############################################################################

SRC=hello.ml

LIBS= -thread -package lwt,tyxml,eliom,eliom.server

##############################################################################
# Generic ocaml variables
##############################################################################

# can also use eliomc and eliomopt
OCAMLC=ocamlfind ocamlc $(DBG) $(LIBS)
OCAMLOPT=ocamlfind ocamlopt $(DBG) $(LIBS)
OCAMLDEP= ocamlfind ocamldep

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

byte: $(OBJS)

opt: $(OBJSOPT)
	$(CMXSCMD)

run:
	../../server/src/server/ocsigenserver -c config/hello.conf

clean::
	-rm -f var/*.log var/ocsigen_command
	rm -rf _server

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
