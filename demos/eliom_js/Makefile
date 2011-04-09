#############################################################################
# Configuration section
#############################################################################

##############################################################################
# Variables
##############################################################################

LIBS_SERVER=-package ocsigen.ext.eliom
LIBS_CLIENT=-package ocsigen.ext.eliom_client

INCLUDES= -package ocsigen.ext.eliom -package ocsigen.ext.eliom_client

FLAGS=-dtypes

ELIOMJS=/opt/local/lib/ocaml/site-lib/ocsigen/client/eliom_client.js
REQUIREMENTSML=/opt/local/lib/ocaml/site-lib/oclosure/requirements.ml

##############################################################################
# Top rules
##############################################################################

all: server.cma client.js

server.cma: app_server.cmo
	ocamlfind ocamlc -a -o $@ -thread $(LIBS_SERVER) $^
app_server.cmo: app_server.ml
	ocamlfind ocamlc -thread -c $(FLAGS) $(INCLUDES) $^

client.js: app_client.cmo
	ocamlfind ocamlc $(LIBS_CLIENT) -linkpkg $^ -o client
	js_of_ocaml -pretty . $(ELIOMJS) client -o $@
	js_of_ocaml -pretty /tmp/static $(ELIOMJS) client -o /tmp/static/client.js
	ocaml str.cma $(REQUIREMENTSML) /tmp/static/client.js

app_client.cmo: app_client.ml
	ocamlfind ocamlc -thread -c $(FLAGS) $(INCLUDES)  $^

clean::
	rm -f client client.js

app.type.mli: app.eliom
	ocamlfind ocamlc -thread -syntax camlp4o -ppopt -impl -package ocsigen.ext.eliom,ocsigen.ext.eliom.syntax.type -i -impl app.eliom > $@
app_server.ml: app.eliom app.type.mli
	camlp4o ../../eliom/syntax/pa_eliom_seed.cmo ../../eliom/syntax/pa_eliom_client_server.cmo ../../web_js/js_of_ocaml/lib/syntax/pa_js.cmo -type app.type.mli  pr_o.cmo  -impl app.eliom -o $@
app_client.ml: app.eliom app.type.mli
	camlp4o ../../eliom/syntax/pa_eliom_seed.cmo ../../eliom/syntax/pa_eliom_client_client.cmo ../../web_js/js_of_ocaml/lib/syntax/pa_js.cmo -type app.type.mli  pr_o.cmo  -impl app.eliom -o $@

beforedepend:: app.type.mli app_server.ml app_client.ml


run: 
	ocsigen -c ocsigen.conf

old1:
	ocamlfind ocamlc -thread -syntax camlp4o -ppopt -impl -package ocsigen.ext.eliom,ocsigen.ext.eliom.syntax.type -i -impl app.eliom > app.type.mli
	ocamlfind ocamlc -package ocsigen.ext.eliom.syntax.server -package ocsigen.ext.eliom -syntax camlp4o -ppopt -type -ppopt app.type.mli -ppopt -impl -thread -o app_server.cmo -c -impl app.eliom
	ocamlfind ocamlc -a -o server.cma -thread -package ocsigen.ext.eliom.syntax.server -package ocsigen.ext.eliom app_server.cmo
	ocamlfind ocamlc -package ocsigen.ext.eliom_client.syntax -package ocsigen.ext.eliom_client -syntax camlp4o -ppopt -type -ppopt app.type.mli -ppopt -impl -o app_client.cmo -c -impl app.eliom
	ocamlfind ocamlc -package ocsigen.ext.eliom_client.syntax -package ocsigen.ext.eliom_client -linkpkg app_client.cmo -o client
	js_of_ocaml -pretty /tmp/static /opt/local/lib/ocaml/site-lib/ocsigen/client/eliom_client.js client -o /tmp/static/client.js
	ocaml str.cma /opt/local/lib/ocaml/site-lib/oclosure/requirements.ml /tmp/static/client.js

##############################################################################
# Generic ocaml variables
##############################################################################

#dont use -custom, it makes the bytecode unportable.
OCAMLCFLAGS?=-g -dtypes -thread # -w A

# This flag is also used in subdirectories so don't change its name here.
OPTFLAGS?=-thread

OCAMLC=ocamlc$(OPTBIN) $(OCAMLCFLAGS)  $(INCLUDES)
OCAMLOPT=ocamlopt$(OPTBIN) $(OPTFLAGS) $(INCLUDES)
OCAMLLEX=ocamllex #-ml # -ml for debugging lexer, but slightly slower
OCAMLYACC=ocamlyacc -v
OCAMLDEP=ocamldep $(PP) $(INCLUDES)
OCAMLMKTOP=ocamlmktop -g -custom $(INCLUDES) -thread

# can also be set via 'make static'
STATIC= #-ccopt -static

# can also be unset via 'make purebytecode'
BYTECODE_STATIC=-custom


##############################################################################
# Generic ocaml rules
##############################################################################

.SUFFIXES: .ml .mli .cmo .cmi .cmx

.ml.cmo:
	$(OCAMLC)  -c $<
.mli.cmi:
	$(OCAMLC)  -c $<
.ml.cmx:
	$(OCAMLOPT)  -c $<

.ml.mldepend: 
	$(OCAMLC) -i $<

clean::
	rm -f *.cm[ioxa] *.o *.a *.cmxa *.annot
	rm -f *~ .*~ *.exe gmon.out #*#

distclean::
	rm -f .depend

beforedepend::

depend:: beforedepend
	$(OCAMLDEP) *.mli *.ml > .depend

-include .depend
