#############################################################################
# Configuration section
#############################################################################

##############################################################################
# Variables
##############################################################################

LIBS_SHARED= -package deriving-ocsigen.syntax,js_of_ocaml.deriving.syntax -syntax camlp4o
LIBS_SERVER= -thread -package cairo,tyxml,eliom,eliom.server \
  $(LIBS_SHARED)
LIBS_CLIENT= -package js_of_ocaml,eliom,eliom.client,oclosure \
  -package eliom.syntax,js_of_ocaml.syntax -syntax camlp4o \
  $(LIBS_SHARED)

all:
	eliomc -dtypes -c shared.ml
	eliomc -dtypes -c -package cairo server.ml
	js_of_eliom -c shared.ml
	js_of_eliom -c -package oclosure client.ml
	eliomc  -c -noinfer app.eliom
	eliomc  -a -o var/app.cma lib.cmo _server/shared.cmo _server/server.cmo _server/app.cmo
	eliomc  -infer app.eliom
	js_of_eliom -c app.eliom
	js_of_eliom -o var/static/app.js -package oclosure _client/shared.cmo _client/client.cmo _client/app.cmo
	oclosure_req var/static/app.js

annot:
	ocamlfind ocamlc -dtypes -c lib.ml
	ocamlfind ocamlc -dtypes -c $(LIBS_SHARED) shared.ml
	ocamlfind ocamlc -dtypes -c $(LIBS_SERVER) server.ml
	ocamlfind ocamlc -dtypes -c $(LIBS_CLIENT) client.ml
	rm -f client.cm* shared.cm* server.cm*

run:
	ocsigenserver -c config/ocsigen.conf

clean::
	rm -f *.cm* *.annot
	rm -rf _client _server

##############################################################################
# Pad's stuff
##############################################################################

orig_compilation:
	eliomc  -c -noinfer -package cairo,unix   app.eliom
	eliomc  -a -o var/app.cma _server/app.cmo
	eliomc  -infer -package cairo,unix app.eliom
	js_of_eliom -c -package oclosure app.eliom
	js_of_eliom -o var/static/app.js -package oclosure _client/app.cmo
	oclosure_req var/static/app.js
#ln -fs /data/users/pad/github/fork-ocsigen/demos/app_orig/css local/var/www/static/css

clean::
