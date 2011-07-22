#############################################################################
# Configuration section
#############################################################################

MAKESUBDIRS=commons external \
  web_js web_html web_css \
  database \
  server eliom \
  demos/hello demos/graffiti \

#  ocsimore other/ocsforge

clean::
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i clean; done 

depend::

configure::


##############################################################################
# Pad specific rules
##############################################################################

DARCSREPOS=\
 external/ocamllwt web_html/tyxml \
 server eliom \
 web_js/js_of_ocaml web_js/oclosure \
 ocsimore other/ocsforge \
 demos/graffiti

update_darcs:
	set -e; for i in $(DARCSREPOS); do pushd .; cd $$i; darcs pull; popd; done 
