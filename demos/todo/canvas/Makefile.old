#############################################################################
# Configuration section
#############################################################################

##############################################################################
# Variables
##############################################################################

LIBS_SERVER=-package ocsigen.ext.eliom
LIBS_CLIENT=-package ocsigen.ext.eliom_client

INCLUDES_SERVER=-package ocsigen.ext.eliom \
  -package ocsigen.deriving.syntax -syntax camlp4o 
INCLUDES_CLIENT=-package ocsigen.ext.eliom_client \
  -package js_of_ocaml.syntax -syntax camlp4o

FLAGS=-dtypes -g

##############################################################################
# Top rules
##############################################################################

all: server.cma client.js

server.cma: app_server.cmo
	ocamlfind ocamlc -a -o $@ -thread $(LIBS_SERVER) $^

ELIOMJS=$(shell ocamlfind query ocsigen.ext.eliom_client)/eliom_client.js
REQUIREMENTSML=$(shell ocamlfind query oclosure)/requirements.ml

client.js: app_client.cmo
	ocamlfind ocamlc $(LIBS_CLIENT) -linkpkg $^ -o client
	js_of_ocaml -pretty . $(ELIOMJS) client -o $@
	js_of_ocaml -pretty /tmp/static $(ELIOMJS) client -o /tmp/static/client.js
	ocaml str.cma $(REQUIREMENTSML) /tmp/static/client.js

clean::
	rm -f client client.js

app_server.cmo: app_server.ml
	ocamlfind ocamlc -thread -c $(FLAGS) $(INCLUDES_SERVER) $^
app_client.cmo: app_client.ml
	ocamlfind ocamlc -thread -c $(FLAGS) $(INCLUDES_CLIENT) $^

# .eliom file expansion
app.type.mli: app.eliom
	ocamlfind ocamlc -thread -syntax camlp4o -ppopt -impl -package ocsigen.ext.eliom,ocsigen.ext.eliom.syntax.type -i -impl app.eliom > $@
app_server.ml: app.eliom app.type.mli
	camlp4o ../../eliom/syntax/pa_eliom_seed.cmo ../../eliom/syntax/pa_eliom_client_server.cmo ../../web_js/js_of_ocaml/lib/syntax/pa_js.cmo -type app.type.mli  pr_o.cmo  -impl app.eliom -o $@
app_client.ml: app.eliom app.type.mli
	camlp4o ../../eliom/syntax/pa_eliom_seed.cmo ../../eliom/syntax/pa_eliom_client_client.cmo ../../web_js/js_of_ocaml/lib/syntax/pa_js.cmo -type app.type.mli  pr_o.cmo  -impl app.eliom -o $@

beforedepend:: app.type.mli app_server.ml app_client.ml

run: 
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
	ocamlfind ocamldep $(INCLUDES) *.mli *.ml > .depend

-include .depend
