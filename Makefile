#############################################################################
# Configuration section
#############################################################################
include Makefile.config # this file includes in turn Makefile.options

##############################################################################
# Variables
##############################################################################
TOP=$(shell pwd)

PROGS=server/ocsigen

#------------------------------------------------------------------------------
#package dependencies
#------------------------------------------------------------------------------
# see Makefile.config

#------------------------------------------------------------------------------
# Main variables
#------------------------------------------------------------------------------

#pad: other dirs: 
# commons external, web_css web_js web_html, database, files ocsimore ocsimoron
# demos docs 

DIRS=lib http server extensions     eliom #tests
MAKESUBDIRS=$(DIRS)

ELIOMTESTSCMOA= tests/eliom_testsuite.cma tests/monitoring.cmo	\
	tests/miniwiki/miniwiki.cmo $(DUCEELIOMTESTS)
ELIOMTESTSCMI = tests/eliom_testsuite1.cmi tests/eliom_testsuite2.cmi tests/eliom_testsuite3.cmi tests/eliom_testsuite.cmi

ifeq "$(BYTECODE)" "YES"
BYTE=byte
ELIOMTESTSBYTE=$(ELIOMTESTSCMOA)
else
BYTE=
ELIOMTESTSBYTE=
endif

ifeq "$(NATIVECODE)" "YES"
OPT=opt
ELIOMTESTSOPT=$(EXAMPLECMXS)
DEPOPT=web_htmlpre.opt
else
OPT=
ELIOMTESTSOPT=
endif

ELIOMTESTS=$(ELIOMTESTSBYTE) $(ELIOMTESTSOPT) $(ELIOMTESTSCMI)

METAS= files/META \
  files/META.ocsigen_xhtml files/META.ocsigen \
  files/META.eliom_tests files/META.eliom_tests.global

##############################################################################
# Top rules
##############################################################################

.PHONY: all opt deriving clean distclean servertop

all: $(BYTE) $(OPT) $(OCSIGENNAME).conf.local $(METAS)

byte: 
#	$(MAKE) deriving
	$(MAKE) rec 

opt: 
	$(MAKE) rec.opt 

rec:
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i byte || exit 1; done 

rec.opt:
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i opt || exit 1; done 


deriving:
	cd external/ocamlderiving && $(MAKE) all
	rm -rf external/ocamlderiving/tmp
	mkdir -p external/ocamlderiving/tmp
	cd external/ocamlderiving && OCAMLFIND_DESTDIR=`pwd`/tmp $(MAKE) install

servertop: files/META.ocsigen
	cd server && ${MAKE} top

#------------------------------------------------------------------------------
# META files
#------------------------------------------------------------------------------

external/ocamlderiving/lib/META.gen:
	echo "Please run make depend"
	exit 1

VERSION := $(shell head -n 1 VERSION)

# sed commands used for generation of META files
SED_COMMAND_FOR_META =
SED_COMMAND_FOR_META += -e "s/_VERSION_/$(VERSION)/"
SED_COMMAND_FOR_META += -e "s/_CAMLZIPNAME_/$(CAMLZIPNAME)/"
SED_COMMAND_FOR_META += -e "s@_DIRECTORY_@$(MODULEINSTALLDIR)/$(OCSIGENNAME)@"
SED_COMMAND_FOR_META += -e "s@_OCSINAME_@$(OCSIGENNAME)@"

files/META: files/META.in VERSION external/ocamlderiving/lib/META.gen
	sed $(SED_COMMAND_FOR_META) < $< > $@
	echo "package \"deriving\" (" >> $@
	echo "  directory = \"deriving\"" >> $@
	sed 's/^/  /' external/ocamlderiving/lib/META.gen \
	| sed 's/_DERIVING_/ocsigen.deriving/g' >> $@
	echo ")" >> $@

files/META.ocsigen_xhtml: files/META.ocsigen_xhtml.in VERSION
	sed $(SED_COMMAND_FOR_META) < $< > $@

files/META.ocsigen: files/META.in VERSION
	-ln -sf ../server/ocsigen.cma extensions
	-ln -sf ../eliom/eliom.cma extensions
	-ln -sf ../eliom/eliom_duce.cma extensions
	-ln -sf ../eliom/client/eliom_client.cma extensions
	-ln -sf ../eliom/client/eliom_client_main.cmo extensions
	-ln -sf ../web_html/xhtml.cma extensions
	-ln -sf ../web_html/xhtmlpretty.cma extensions
	-ln -sf ../web_html/xhtmlsyntax.cma extensions
	-ln -sf ../eliom/eliom.cmxa extensions
	-ln -sf ../eliom/eliom_duce.cmxa extensions
	-ln -sf ../web_html/xhtml.cmxa extensions
	-ln -sf ../web_html/xhtmlpretty.cmxa extensions
	-ln -sf ../web_html/xhtmlsyntax.cmxa extensions
	-ln -sf ../eliom/eliom.cmxs extensions
	-ln -sf ../eliom/eliom_duce.cmxs extensions
	-ln -sf ../web_html/xhtml.cmxs extensions
	-ln -sf ../web_html/xhtmlpretty.cmxs extensions
	-ln -sf ../web_html/xhtmlsyntax.cmxs extensions
	-ln -sf ../lib/parsecommandline.cma extensions
	-ln -sf ../lib/parsecommandline.cmxs extensions
	-ln -sf ../lib/donotparsecommandline.cma extensions
	-ln -sf ../lib/donotparsecommandline.cmxs extensions
	-ln -sf ../external/ocamlderiving/tmp/deriving extensions
	-ln -sf ../extensions files/ocsigen
	echo directory = \"$(SRC)/extensions\" > $@
	sed $(SED_COMMAND_FOR_META) -e "s%_MODULEINSTALLDIR_%$(SRC)/extensions%g" < $< >> $@
	echo "package \"deriving\" (" >> $@
	echo "  directory = \"deriving\"" >> $@
	sed 's/^/  /' external/ocamlderiving/lib/META.gen \
	| sed 's/_DERIVING_/ocsigen.deriving/g' >> $@
	echo ")" >> $@
#	sed "s%\"xhtml\" (%\"xhtml\" (\n  directory = \"$(SRC)/web_html/xhtml/\"%g" >> $@

files/META.eliom_tests: files/META.eliom_tests.in VERSION
	sed $(SED_COMMAND_FOR_META) -e "s%_ELIOMTESTSINSTALLDIR_%$(SRC)/tests%g" < $< > $@

files/META.eliom_tests.global: files/META.eliom_tests.in VERSION
	sed $(SED_COMMAND_FOR_META) -e "s%_ELIOMTESTSINSTALLDIR_%$(ELIOMTESTSINSTALLDIR)%g"< $< > $@

ifeq "$(LOGDIR)" ""
LOGDIR = "error"
endif
ifeq "$(STATICPAGESDIR)" ""
STATICPAGESDIR = "error"
endif
ifeq "$(DATADIR)" ""
DATADIR = "error"
endif

$(OCSIGENNAME).conf.local: Makefile.config files/ocsigen.conf.in
	cat files/ocsigen.conf.in \
	| sed s%80\</port\>%8080\</port\>%g \
	| sed s%_LOGDIR_%$(SRC)/var/log%g \
	| sed s%_STATICPAGESDIR_%$(SRC)/files%g \
	| sed s%_CONFIGDIR_%$(SRC)/etc/ocsigen%g \
	| sed s%_DATADIR_%$(SRC)/var/lib%g \
	| sed s%_EXTRALIBDIR_%$(SRC)/extensions/ocsipersist-dbm%g \
	| sed s%_UP_%$(SRC)/tmp%g \
	| sed s%_OCSIGENUSER_%%g \
	| sed s%_OCSIGENGROUP_%%g \
	| sed s%_OCSIGENNAME_%$(OCSIGENNAME)%g \
	| sed s%_COMMANDPIPE_%$(SRC)/var/run/ocsigen_command%g \
	| sed s%_MIMEFILE_%$(SRC)/files/mime.types%g \
	| sed s%_MODULEINSTALLDIR_%$(SRC)/extensions%g \
	| sed s%_ELIOMINSTALLDIR_%$(SRC)/eliom%g \
	| sed s%_ELIOMTESTSINSTALLDIR_%$(SRC)/tests%g \
	| sed s%_METADIR_%`${OCAMLFIND} query stdlib`\"/\>\<findlib\ path=\"$(SRC)/external/ocamlderiving/tmp\"/\>\<findlib\ path=\"$(SRC)/files%g \
	| sed s%_CAMLZIPNAME_%$(CAMLZIPNAME)%g \
	| sed s%files/miniwiki%tests/miniwiki/files%g \
	| sed s%var/lib/miniwiki%tests/miniwiki/wikidata%g \
	| sed s%\<\!--\ \<commandpipe%\<commandpipe%g \
	| sed s%\</commandpipe\>%\</commandpipe\>\ \<\!--%g \
	| sed s%\<\!--\ \<mimefile%\<mimefile%g \
	| sed s%\</mimefile\>%\</mimefile\>\ \<\!--%g \
	| sed s%ocsipersist-dbm.cma%ocsipersist-dbm/ocsipersist-dbm.cma%g \
	| sed s%store\ dir=\"$(SRC)/var/lib\"%store\ dir=\"$(SRC)/var/lib/ocsipersist\"%g \
	> $(OCSIGENNAME).conf.local
	cat $(OCSIGENNAME).conf.local \
	| sed s%[.]cmo%.cmxs%g \
	| sed s%[.]cma%.cmxs%g \
	| sed s%sist-dbm/ocsidbm\"%sist-dbm/ocsidbm.opt\"%g \
	| sed s%sqlite3.cmxs\"/\>%sqlite3.cmxs\"/\>\ \<\!--\ Create\ sqlite3.cmxs\ using:\ ocamlopt\ -shared\ -linkall\ -I\ \<path\ to\ ocaml\'s\ sqlite3\ directory\>\ -o\ sqlite3.cmxs\ \<path\ to\>/libsqlite3_stubs.a\ \<path\ to\>/sqlite3.cmxa\ --\>%g \
	> $(OCSIGENNAME).conf.opt.local


#------------------------------------------------------------------------------
# clean/depend
#------------------------------------------------------------------------------

clean:
	make -C external/ocamlderiving clean
	@for i in $(DIRS) ; do $(MAKE) -C $$i clean ; done
	rm -f $(OCSIGENNAME).conf.local $(OCSIGENNAME).conf.opt.local
	rm -f $(METAS) $(OCSIGENNAME)-*.tar.gz
	find . -name "*~" -delete
	make -C external clean
	make -C web_js clean
	make -C web_html clean

depend: deriving
	$(MAKE) -C web_html depend
	$(MAKE) -C web_html web_htmlpre.byte $(DEPOPT)
	@for i in $(DIRS) ; do $(MAKE) -C $$i depend ; done

##############################################################################
# Documentation
##############################################################################
doc:
	$(MAKE) -C doc

##############################################################################
# Install
##############################################################################

include Makefile.install

##############################################################################
# Package rules
##############################################################################

distclean: clean
	cd external/ocamlderiving && make clean
	find . -name "*depend" -delete
	make -C doc clean
	rm -f Makefile.config

dist:
	DARCS_REPO=$(PWD) darcs dist -d $(OCSIGENNAME)-$(VERSION)

##############################################################################
# Developer rules
##############################################################################
