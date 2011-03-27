
PROJECTNAME := graffiti

# Put here all the source files, in right order.
# You may mix .eliom and .ml files.
# Warning: no automatic dependencies.

SERVERFILES := shared.ml server.ml ${PROJECTNAME}.eliom
CLIENTFILES := shared.ml client.ml ${PROJECTNAME}.eliom

# Put here all the requested packages (no prerequest).
# e.g -package lwt

SERVERLIB := -package ocsigen.deriving.syntax -package cairo
CLIENTLIB := -package ocsigen.deriving.syntax -package oclosure -package js_of_ocaml.syntax

# You may adjust those variables to your installation

OCAMLFIND      := ocamlfind
OCAML          := ocaml
JS_OF_OCAML    := js_of_ocaml

ELIOMCLIENTDIR := $(shell ${OCAMLFIND} query ocsigen.ext.eliom_client)
OCLOSUREDIR    := $(shell ${OCAMLFIND} query oclosure)

TEMP           := _build

STATICDIR      := /tmp/static

########################################################################

.PHONY: all byte opt client server-byte server-opt

all: server-byte server-opt client
byte: server-byte client
opt: server-opt client

client: $(STATICDIR)/$(PROJECTNAME).js $(STATICDIR)/$(PROJECTNAME)_req.js
server-byte: $(PROJECTNAME).cma
server-opt: $(PROJECTNAME).cmxs

########################################################################
include Makefile.eliom

########################################################################

run:
	cp -a css/ $(STATICDIR)
	ocsigen -c config/${PROJECTNAME}.conf

########################################################################

clean::
	-rm -rf ${TEMP} \
	   ${PROJECTNAME}.cma  \
	   ${PROJECTNAME}.a  ${PROJECTNAME}.cmxa ${PROJECTNAME}.cmxs \
	   $(STATICDIR)/${PROJECTNAME}.js $(STATICDIR)/${PROJECTNAME}_req.js

clean::
	rm -f var/*.log var/ocsigen_command


distclean:
	-rm -f *~ .\#* \#*\#
