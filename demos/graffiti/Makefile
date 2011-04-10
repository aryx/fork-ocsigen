#############################################################################
# Configuration section
#############################################################################

##############################################################################
# Variables
##############################################################################

SRC_CLIENT=shared.ml client.ml app_client.ml
SRC_SERVER=shared.ml server.ml app_server.ml

LIBS_SERVER=-package cairo -package ocsigen.ext.eliom 
LIBS_CLIENT=-package js_of_ocaml -package oclosure \
 -package ocsigen.ext.eliom_client

INCLUDES_SERVER=-package cairo -package ocsigen.ext.eliom \
  -package ocsigen.deriving.syntax -syntax camlp4o 
INCLUDES_CLIENT=-package js_of_ocaml -package oclosure -package ocsigen.ext.eliom_client \
  -package js_of_ocaml.syntax -syntax camlp4o

INCLUDES_SHARED=-package ocsigen.deriving.syntax -syntax camlp4o

FLAGS=-dtypes -g

ELIOMJS=/opt/local/lib/ocaml/site-lib/ocsigen/client/eliom_client.js
REQUIREMENTSML=/opt/local/lib/ocaml/site-lib/oclosure/requirements.ml

##############################################################################
# Top rules
##############################################################################

all: server.cma client.js

server.cma: $(SRC_SERVER:.ml=.cmo)
	ocamlfind ocamlc -a -o $@ -thread $(LIBS_SERVER) $^

client.js: $(SRC_CLIENT:.ml=.cmo)
	ocamlfind ocamlc $(LIBS_CLIENT) -linkpkg $^ -o client
	js_of_ocaml -pretty . $(ELIOMJS) client -o $@
	js_of_ocaml -pretty /tmp/static $(ELIOMJS) client -o /tmp/static/client.js
	ocaml str.cma $(REQUIREMENTSML) /tmp/static/client.js

clean::
	rm -f client client.js

shared.cmo: shared.ml
	ocamlfind ocamlc -thread -c $(FLAGS) $(INCLUDES_SHARED) $^
server.cmo: server.ml
	ocamlfind ocamlc -thread -c $(FLAGS) $(INCLUDES_SERVER) $^
client.cmo: client.ml
	ocamlfind ocamlc -thread -c $(FLAGS) $(INCLUDES_CLIENT) $^

app_server.cmo: app_server.ml
	ocamlfind ocamlc -thread -c $(FLAGS) $(INCLUDES_SERVER) $^
app_client.cmo: app_client.ml
	ocamlfind ocamlc -thread -c $(FLAGS) $(INCLUDES_CLIENT) $^


# .eliom file expansion
app.type.mli: app.eliom shared.cmo server.cmo client.cmo
	ocamlfind ocamlc -thread -syntax camlp4o -ppopt -impl -package ocsigen.ext.eliom,ocsigen.ext.eliom.syntax.type -i -impl app.eliom > $@
app_server.ml: app.eliom app.type.mli
	camlp4o ../../eliom/syntax/pa_eliom_seed.cmo ../../eliom/syntax/pa_eliom_client_server.cmo ../../web_js/js_of_ocaml/lib/syntax/pa_js.cmo -type app.type.mli  pr_o.cmo  -impl app.eliom -o $@
app_client.ml: app.eliom app.type.mli
	camlp4o ../../eliom/syntax/pa_eliom_seed.cmo ../../eliom/syntax/pa_eliom_client_client.cmo ../../web_js/js_of_ocaml/lib/syntax/pa_js.cmo -type app.type.mli  pr_o.cmo  -impl app.eliom -o $@

beforedepend:: app.type.mli app_server.ml app_client.ml

STATICDIR=/tmp/static
TOP=../..
run: 
	rm -f $(STATICDIR)/css/*
	cp -a css/ $(STATICDIR)
	cp -a images/ $(STATICDIR)
	cp -a $(TOP)/files/mime.types $(STATICDIR)
	ocsigen -c ocsigen.conf

##############################################################################
# Generic ocaml rules
##############################################################################

.SUFFIXES: .ml .mli .cmo .cmi .cmx

.ml.cmo:
	ocamlfind ocamlc -thread -c $(FLAGS) $(INCLUDES) $^
.mli.cmi:
	ocamlfind ocamlc -thread -c $(FLAGS) $(INCLUDES) $^
.ml.cmx:
	ocamlfind ocamlopt -thread -c $(FLAGS) $(INCLUDES) $^

clean::
	rm -f *.cm[ioxa] *.o *.a *.cmxa *.annot
	rm -f *~ .*~ *.exe gmon.out #*#

distclean::
	rm -f .depend

beforedepend::

depend:: beforedepend
	ocamlfind ocamldep $(INCLUDES_SHARED) $(INCLUDES_CLIENT)  $(SRC_CLIENT) > .depend
	ocamlfind ocamldep $(INCLUDES_SHARED) $(INCLUDES_SERVER)  $(SRC_SERVER) >> .depend

-include .depend
