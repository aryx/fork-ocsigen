#############################################################################
# Configuration section
#############################################################################

##############################################################################
# Variables
##############################################################################

all:
	ocamlc -dtypes -c lib.ml
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

run:
	ocsigenserver -c config/ocsigen.conf

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
#eliomopt  -c -noinfer -package cairo,unix app.eliom
#eliomopt  -a -o local/var/www/lib/app.cmxa _server/app.cmx
#eliomopt  -shared -linkall -o local/var/www/lib/app.cmxs local/var/www/lib/app.cmxa
#ln -fs /data/users/pad/github/fork-ocsigen/demos/app_orig/css local/var/www/static/css

clean::
