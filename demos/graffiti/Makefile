#############################################################################
# Configuration section
#############################################################################

##############################################################################
# Variables
##############################################################################

LIBS_SHARED= -package deriving-ocsigen.syntax,js_of_ocaml.deriving.syntax \
  -syntax camlp4o
LIBS_SERVER= -thread -package cairo,tyxml,eliom,eliom.server \
  $(LIBS_SHARED)
LIBS_CLIENT= -package js_of_ocaml,eliom,eliom.client,oclosure \
  -package eliom.syntax,js_of_ocaml.syntax -syntax camlp4o \
  $(LIBS_SHARED)

##############################################################################
# Top rules
##############################################################################

all: var/app.cma var/static/app_oclosure.js

# server-side
var/app.cma: _server/lib.cmo _server/shared.cmo _server/server.cmo _server/app.cmo
	eliomc  -a -o $@ $^

_server/lib.cmo: lib.ml
	eliomc -c $^

_server/shared.cmo: shared.ml
	eliomc -c $^

_server/server.cmo: server.ml
	eliomc -c -package cairo $^

_server/app.cmo: app.eliom
	eliomc -c -noinfer $^

# client-side
var/static/app_oclosure.js: var/static/app.js
	oclosure_req $^

var/static/app.js: _client/shared.cmo _client/client.cmo _client/app.cmo
	js_of_eliom -o $@ -package oclosure  $^

_client/shared.cmo: shared.ml
	js_of_eliom -c $^

_client/client.cmo: client.ml
	js_of_eliom -c -package oclosure $^

_client/app.cmo: app.eliom
	eliomc  -c -noinfer $^
	eliomc  -infer app.eliom
	js_of_eliom -c app.eliom


annot:
	ocamlfind ocamlc -dtypes -c lib.ml
	ocamlfind ocamlc -dtypes -c $(LIBS_SHARED) shared.ml
	ocamlfind ocamlc -dtypes -c $(LIBS_SERVER) server.ml
	ocamlfind ocamlc -dtypes -c $(LIBS_CLIENT) client.ml
	rm -f lib.cm* client.cm* shared.cm* server.cm*

run:
	ocsigenserver -c config/ocsigen.conf

css/closure:
	ln -fs $(shell ocamlfind query oclosure)/closure/goog/css/ css/closure

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
