include Makefile.config
include Makefile.filelist

VERSION := $(shell head -n 1 VERSION)

# sed commands used for generation of META files
SED_COMMAND_FOR_META =
SED_COMMAND_FOR_META += -e "s/_VERSION_/$(VERSION)/"
SED_COMMAND_FOR_META += -e "s/_CAMLZIPNAME_/$(CAMLZIPNAME)/"
SED_COMMAND_FOR_META += -e "s@_DIRECTORY_@$(MODULEINSTALLDIR)/$(OCSIGENNAME)@"
SED_COMMAND_FOR_META += -e "s@_OCSINAME_@$(OCSIGENNAME)@"

ifeq "$(LOGDIR)" ""
LOGDIR = "error"
endif
ifeq "$(STATICPAGESDIR)" ""
STATICPAGESDIR = "error"
endif
ifeq "$(DATADIR)" ""
DATADIR = "error"
endif

ifeq "$(OCSIPERSISTSQLITE)" "YES"
SQLITECMATOINSTALL= extensions/ocsipersist-sqlite.cma
else
endif

ifeq "$(CAMLZIP)" "YES"
DEFLATEMODCMOTOINSTALL= extensions/deflatemod.cmo
else
endif

ifeq "$(OCSIPERSISTDBM)" "YES"
DBMCMATOINSTALL= extensions/ocsipersist-dbm/ocsipersist-dbm.cma 
else
endif

METAS = files/META files/META.ocsigen_xhtml files/META.ocsigen files/META.eliom_tests files/META.eliom_tests.global


INSTALL = install
TARGETSBYTE = commons.byte web_html.byte http.byte server.byte extensions.byte eliom.byte tests.byte

# plugins are cma (and cmxs) that can be loaded dynamically by the server
PLUGINSCMATOINSTALL = $(SQLITECMATOINSTALL) $(DBMCMATOINSTALL) \
	eliom/eliom.cma $(DEFLATEMODCMATOINSTALL) $(DUCECMA) \
	commons/parsecommandline.cma commons/donotparsecommandline.cma
PLUGINSCMOTOINSTALL = \
	$(SQLITECMOTOINSTALL) $(DBMCMOTOINSTALL) $(DEFLATEMODCMOTOINSTALL) \
	extensions/staticmod.cmo extensions/cgimod.cmo \
        extensions/revproxy.cmo extensions/userconf.cmo \
        extensions/outputfilter.cmo extensions/authbasic.cmo \
	extensions/redirectmod.cmo extensions/rewritemod.cmo \
	extensions/accesscontrol.cmo extensions/extendconfiguration.cmo \
	extensions/ocsigen_comet.cmo \
	commons/polytables.cmo $(DUCECMO)
PLUGINSCMITOINSTALL = extensions/ocsipersist.cmi \
       eliom/eliom_mkforms.cmi eliom/eliom_mkreg.cmi \
       eliom/eliom_tools_common.cmi eliom/eliom_tools.cmi \
       $(DUCECMI) \
       eliom/eliom_config.cmi eliom/eliom_request_info.cmi \
       eliom/eliom_state.cmi eliom/eliom_references.cmi \
       eliom/eliom_parameters.cmi \
       eliom/eliom_services.cmi eliom/eliom_output.cmi \
       eliom/eliom_uri.cmi \
	eliom/extensions/eliom_s2s.cmi eliom/extensions/eliom_openid.cmi \
       eliom/eliommod.cmi eliom/eliom_common.cmi eliom/eliom_extensions.cmi \
       eliom/eliom_client_types.cmi \
       eliom/eliom_react.cmi eliom/eliom_comet.cmi eliom/eliom_bus.cmi \
       eliom/extensions/atom_feed.cmi eliom/extensions/eliom_atom.cmi \
       extensions/ocsigen_comet.cmi \
       extensions/accesscontrol.cmi extensions/extendconfiguration.cmi \
       commons/polytables.cmi \
       eliom/eliommod_cli.cmi


# Put here only those which do not have cmxs (Vincent: Why?)
CMATOINSTALL = web_html/xhtmlsyntax.cma web_html/xhtmlpretty.cma	\
	web_html/xhtml.cma server/ocsigen.cma 
CMOTOINSTALL = server/server_main.cmo
DOCPREF=
ELIOMTESTSCMOA = tests/eliom_testsuite.cma tests/monitoring.cmo	\
	tests/miniwiki/miniwiki.cmo $(DUCEELIOMTESTS)

ELIOMTESTSCMI = tests/eliom_testsuite1.cmi tests/eliom_testsuite2.cmi tests/eliom_testsuite3.cmi tests/eliom_testsuite.cmi

ifeq "$(BYTECODE)" "YES"
TOINSTALLBYTE=$(CMATOINSTALL) $(CMOTOINSTALL)
PLUGINSTOINSTALLBYTE=$(PLUGINSCMATOINSTALL) $(PLUGINSCMOTOINSTALL)
ELIOMTESTSBYTE=$(ELIOMTESTSCMOA)
BYTE=byte
else
TOINSTALLBYTE=
PLUGINSTOINSTALLBYTE=
ELIOMTESTSBYTE=
BYTE=
endif

ifeq "$(NATDYNLINK)" "YES"
CMXS=$(PLUGINSCMOTOINSTALL:.cmo=.cmxs) $(PLUGINSCMATOINSTALL:.cma=.cmxs)
EXAMPLECMXS=$($(ELIOMTESTSCMOA:.cmo=.cmxs):.cma=.cmxs)
else
CMXS=
EXAMPLECMXS=
endif

ifeq "$(NATIVECODE)" "YES"
PLUGINSTOINSTALLX=$(CMXS)

TOINSTALLXTEMP=$(CMAOTOINSTALL:.cmo=.cmx)
TOINSTALLX=$(CMATOINSTALL:.cma=.cmxa) \
           $(CMATOINSTALL:.cma=.a) \
	   $(CMOTOINSTALL:.cmo=.cmx) \
	   $(CMOTOINSTALL:.cmo=.o) \
	   $(PLUGINSCMOTOINSTALL:.cmo=.cmx) \
	   $(PLUGINSCMOTOINSTALL:.cmo=.o) \
	   $(PLUGINSCMATOINSTALL:.cma=.cmxa) \
	   $(PLUGINSCMATOINSTALL:.cma=.a)
ELIOMTESTSOPT=$(EXAMPLECMXS)
OPT=opt
DEPOPT=web_htmlpre.opt
else
TOINSTALLX=
PLUGINSTOINSTALLX=
ELIOMTESTSOPT=
OPT=
endif

STATICSTUBS = server/lib$(OCSIGENNAME).a

PLUGINSTOINSTALL=$(PLUGINSTOINSTALLBYTE) $(PLUGINSTOINSTALLX)
TOINSTALL=$(TOINSTALLBYTE) $(TOINSTALLX) $(CMITOINSTALL) $(PLUGINSCMITOINSTALL) $(PLUGINSTOINSTALL) $(STATICSTUBS) files/META


ELIOMSYNTAXTOINSTALL= \
	eliom/syntax/pa_eliom_seed.cmo \
	eliom/syntax/pa_eliom_client_client.cmo \
	eliom/syntax/pa_eliom_client_server.cmo \
	eliom/syntax/pa_eliom_type_filter.cmo

CLIENTCMOTOINSTALL= \
	eliom/client/eliom_client.cma eliom/client/eliom_client_main.cmo \
	eliom/client/eliom_client.js \
	eliom/client/dlleliom_client.so

CLIENTCMITOINSTALL= \
        eliom/client/eliom_client.cmi \
	eliom/client/eliom_common_comet.cmi \
        eliom/client/eliom_output.cmi \
        eliom/client/ocsigen_cookies.cmi \
        eliom/client/xhtml5types.cmi \
        eliom/client/eliom_client_comet.cmi \
        eliom/client/eliom_client_bus.cmi \
        eliom/client/eliom_mkforms.cmi \
        eliom/client/eliom_process.cmi \
        eliom/client/xHTML.cmi \
        eliom/client/eliom_client_react.cmi \
        eliom/client/eliom_request.cmi \
        eliom/client/ocsigen_lib.cmi \
        eliom/client/xhtmltypes.cmi \
        eliom/client/eliom_services.cmi \
        eliom/client/polytables.cmi \
        eliom/client/xML.cmi \
        eliom/client/eliom_client_types.cmi \
        eliom/client/eliom_config.cmi \
        eliom/client/eliom_request_info.cmi \
        eliom/client/eliom_state.cmi \
        eliom/client/regexp.cmi \
        eliom/client/eliom_common.cmi \
        eliom/client/eliom_parameters.cmi \
        eliom/client/eliom_uri.cmi \
        eliom/client/xHTML5.cmi \
	eliom/client/eliommod_cli.cmi

ELIOMTESTS=$(ELIOMTESTSBYTE) $(ELIOMTESTSOPT) $(ELIOMTESTSCMI)

REPS=$(TARGETSBYTE:.byte=)
STD_METAS_DIR=$(MODULEINSTALLDIR)

all: $(BYTE) $(OPT) $(OCSIGENNAME).conf.local $(METAS)

byte: web_htmlpre.byte $(TARGETSBYTE)

opt: web_htmlpre.opt $(TARGETSBYTE:.byte=.opt)

.PHONY: $(REPS) deriving clean distclean


commons: commons.byte

commons.byte:
	$(MAKE) -C commons byte

commons.opt:
	$(MAKE) -C commons opt

web_html: web_html.byte

web_html.byte:
#	touch web_html/.depend
#	$(MAKE) -C web_html depend
	$(MAKE) -C web_html byte

web_htmlpre.byte:
#	$(MAKE) -C web_html depend
	$(MAKE) -C web_html web_htmlpre.byte

web_htmlpre.opt:
	$(MAKE) -C web_html web_htmlpre.opt

deriving:
	cd external/ocamlderiving && $(MAKE) all
	rm -rf external/ocamlderiving/tmp
	mkdir -p external/ocamlderiving/tmp
	cd external/ocamlderiving && OCAMLFIND_DESTDIR=`pwd`/tmp $(MAKE) install

web_html.opt:
#	touch web_html/.depend
#	$(MAKE) -C web_html depend
	$(MAKE) -C web_html opt

http: http.byte

http.byte:
	$(MAKE) -C http byte

http.opt:
	$(MAKE) -C http opt

extensions: extensions.byte

extensions.byte:
	$(MAKE) -C extensions byte

extensions.opt:
	$(MAKE) -C extensions opt

eliom: eliom.byte

eliom.byte:
	$(MAKE) -C eliom byte

eliom.opt:
	$(MAKE) -C eliom opt

tests: tests.byte

tests.byte:
	$(MAKE) -C tests byte

tests.opt:
	$(MAKE) -C tests opt

server: server.byte

server.byte:
	$(MAKE) -C server byte

server.opt:
	$(MAKE) -C server opt

.PHONY: servertop
servertop: files/META.ocsigen
	cd server && ${MAKE} top

doc:
	$(MAKE) -C doc

external/ocamlderiving/lib/META.gen:
	echo "Please run make depend"
	exit 1

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
	-ln -sf ../commons/parsecommandline.cma extensions
	-ln -sf ../commons/parsecommandline.cmxs extensions
	-ln -sf ../commons/donotparsecommandline.cma extensions
	-ln -sf ../commons/donotparsecommandline.cmxs extensions
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

clean:
	-make -C external/ocamlderiving clean
	-@for i in $(REPS) ; do $(MAKE) -C $$i clean ; done
	-rm -f $(OCSIGENNAME).conf.local $(OCSIGENNAME).conf.opt.local
	-rm -f $(METAS) $(OCSIGENNAME)-*.tar.gz
	-find . -name "*~" -delete
	-make -C external clean
	-make -C web_js clean

distclean: clean
	-cd external/ocamlderiving && make clean
	-find . -name "*depend" -delete
	-make -C doc clean
	-rm -f Makefile.config

depend: deriving
	$(MAKE) -C web_html depend
	$(MAKE) -C web_html web_htmlpre.byte $(DEPOPT)
#	@for i in $(REPS) ; do touch "$$i"/.depend; $(MAKE) -C $$i depend ; done
	@for i in $(REPS) ; do $(MAKE) -C $$i depend ; done


.PHONY: partialinstall install doc docinstall logrotate dist
partialinstall:
	mkdir -p $(TEMPROOT)$(MODULEINSTALLDIR)
	mkdir -p $(TEMPROOT)$(MODULEINSTALLDIR)/$(OCSIGENNAME)/client
	mkdir -p $(TEMPROOT)$(MODULEINSTALLDIR)/$(OCSIGENNAME)/syntax
	mkdir -p $(TEMPROOT)$(ELIOMTESTSINSTALLDIR)
	mkdir -p $(TEMPROOT)$(EXTRALIBDIR)/METAS
	mkdir -p $(TEMPROOT)$(EXTRALIBDIR)/extensions
	mkdir -p $(TEMPROOT)$(STD_METAS_DIR)
	$(MAKE) -C server install
	mkdir -p "$(TEMPROOT)$(MODULEINSTALLDIR)"
	$(OCAMLFIND) install $(OCSIGENNAME) -destdir "$(TEMPROOT)$(MODULEINSTALLDIR)" $(TOINSTALL)
	$(INSTALL) -m 644 $(CLIENTCMITOINSTALL) $(CLIENTCMOTOINSTALL) $(TEMPROOT)$(MODULEINSTALLDIR)/$(OCSIGENNAME)/client
	$(INSTALL) -m 644 $(ELIOMSYNTAXTOINSTALL) $(TEMPROOT)$(MODULEINSTALLDIR)/$(OCSIGENNAME)/syntax
	$(INSTALL) -m 644 $(ELIOMTESTS) $(TEMPROOT)$(ELIOMTESTSINSTALLDIR)
#	$(INSTALL) -m 644 $(PLUGINSTOINSTALL) $(TEMPROOT)$(EXTRALIBDIR)/extensions
	-$(INSTALL) -m 755 extensions/ocsipersist-dbm/ocsidbm $(TEMPROOT)$(EXTRALIBDIR)/extensions
	[ ! -f extensions/ocsipersist-dbm/ocsidbm.opt ] || \
	$(INSTALL) -m 755 extensions/ocsipersist-dbm/ocsidbm.opt $(TEMPROOT)$(EXTRALIBDIR)/extensions
#	$(INSTALL) -m 644 META.ocsigen_ext.global $(TEMPROOT)$(EXTRALIBDIR)/METAS/META.ocsigen_ext
	$(INSTALL) -m 644 files/META.eliom_tests.global $(TEMPROOT)$(EXTRALIBDIR)/METAS/META.eliom_tests
	$(INSTALL) -m 644 files/META.ocsigen_xhtml $(TEMPROOT)$(STD_METAS_DIR)
	chmod a+rx $(TEMPROOT)$(MODULEINSTALLDIR)/$(OCSIGENNAME)
	chmod a+r $(TEMPROOT)$(MODULEINSTALLDIR)/$(OCSIGENNAME)/*
	chmod a+rx $(TEMPROOT)$(MODULEINSTALLDIR)
	chmod a+rx $(TEMPROOT)$(ELIOMTESTSINSTALLDIR)
	chmod a+rx $(TEMPROOT)$(EXTRALIBDIR)
	chmod a+rx $(TEMPROOT)$(EXTRALIBDIR)/METAS
	chmod a+rx $(TEMPROOT)$(EXTRALIBDIR)/extensions
	chmod a+rx $(TEMPROOT)$(STD_METAS_DIR)
	chmod a+rx "$(TEMPROOT)$(MODULEINSTALLDIR)"
	cd external/ocamlderiving && OCAMLFIND_DESTDIR=`${OCAMLFIND} query ${OCSIGENNAME}` $(MAKE) install

docinstall:
	make -C doc install

install: partialinstall
	mkdir -p $(TEMPROOT)$(CONFIGDIR)
	mkdir -p $(TEMPROOT)$(CONFIGDIR)/conf.d
	mkdir -p $(TEMPROOT)$(STATICPAGESDIR)
	mkdir -p $(TEMPROOT)$(STATICPAGESDIR)/miniwiki
	mkdir -p $(TEMPROOT)$(STATICPAGESDIR)/tutorial
	mkdir -p $(TEMPROOT)$(STATICPAGESDIR)/ocsigenstuff
	mkdir -p $(TEMPROOT)$(DATADIR)
	mkdir -p $(TEMPROOT)$(DATADIR)/miniwiki
	mkdir -p `dirname $(TEMPROOT)$(COMMANDPIPE)`
	[ -p $(TEMPROOT)$(COMMANDPIPE) ] || { mkfifo $(TEMPROOT)$(COMMANDPIPE); \
	  chmod 660 $(TEMPROOT)$(COMMANDPIPE); \
	  $(CHOWN) -R $(OCSIGENUSER):$(OCSIGENGROUP) $(TEMPROOT)$(COMMANDPIPE);}
#	-mv $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf.old
	cat files/ocsigen.conf.in \
	| sed s%_LOGDIR_%$(LOGDIR)%g \
	| sed s%_STATICPAGESDIR_%$(STATICPAGESDIR)%g \
	| sed s%_CONFIGDIR_%$(CONFIGDIR)%g \
	| sed s%_DATADIR_%$(DATADIR)%g \
	| sed s%_BINDIR_%$(BINDIR)%g \
	| sed s%_EXTRALIBDIR_%$(EXTRALIBDIR)/extensions%g \
	| sed s%_UP_%$(UPLOADDIR)%g \
	| sed s%_OCSIGENUSER_%$(OCSIGENUSER)%g \
	| sed s%_OCSIGENGROUP_%$(OCSIGENGROUP)%g \
	| sed s%_OCSIGENNAME_%$(OCSIGENNAME)%g \
	| sed s%_COMMANDPIPE_%$(COMMANDPIPE)%g \
	| sed s%_MIMEFILE_%$(CONFIGDIR)/mime.types%g \
	| sed s%_MODULEINSTALLDIR_%$(MODULEINSTALLDIR)/$(OCSIGENNAME)%g \
	| sed s%_ELIOMINSTALLDIR_%$(MODULEINSTALLDIR)/$(OCSIGENNAME)%g \
	| sed s%_ELIOMTESTSINSTALLDIR_%$(ELIOMTESTSINSTALLDIR)%g \
	| sed s%_METADIR_%$(EXTRALIBDIR)/METAS%g \
	| sed s%_CAMLZIPNAME_%$(CAMLZIPNAME)%g \
	> $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf.sample
	cat $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf.sample \
	| sed s%[.]cmo%.cmxs%g \
	| sed s%[.]cma%.cmxs%g \
	> $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf.opt.sample
	-mv $(TEMPROOT)$(CONFIGDIR)/mime.types $(TEMPROOT)$(CONFIGDIR)/mime.types.old
	cp -f files/mime.types $(TEMPROOT)$(CONFIGDIR)
	mkdir -p $(TEMPROOT)$(LOGDIR)
	chmod u+rwx $(TEMPROOT)$(LOGDIR)
	chmod a+rx $(TEMPROOT)$(CONFIGDIR)
	chmod a+rx $(TEMPROOT)$(CONFIGDIR)/conf.d
	[ -f $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf ] || \
	{ cp $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf.sample \
             $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf; \
	  chmod a+r $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf; }
	chmod a+r $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf.sample
	[ -f $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf ] || \
	{ cp $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf.opt.sample \
             $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf.opt; \
	  chmod a+r $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf.opt; }
	chmod a+r $(TEMPROOT)$(CONFIGDIR)/$(OCSIGENNAME).conf.opt.sample
	chmod a+r $(TEMPROOT)$(CONFIGDIR)/mime.types
	$(INSTALL) -m 644 files/tutorial/style.css $(TEMPROOT)$(STATICPAGESDIR)/tutorial
	$(INSTALL) -m 644 files/tutorial/bulles-bleues.png $(TEMPROOT)$(STATICPAGESDIR)/tutorial
	$(INSTALL) -m 644 files/tutorial/ocsigen5.png $(TEMPROOT)$(STATICPAGESDIR)/tutorial
	$(INSTALL) -m 644 files/ocsigenstuff/* $(TEMPROOT)$(STATICPAGESDIR)/ocsigenstuff
	$(INSTALL) -m 644 tests/miniwiki/files/style.css $(TEMPROOT)$(STATICPAGESDIR)/miniwiki
	$(INSTALL) -m 644 tests/miniwiki/wikidata/* $(TEMPROOT)$(DATADIR)/miniwiki
	$(CHOWN) -R $(OCSIGENUSER):$(OCSIGENGROUP) $(TEMPROOT)$(LOGDIR)
	$(CHOWN) -R $(OCSIGENUSER):$(OCSIGENGROUP) $(TEMPROOT)$(STATICPAGESDIR)
	$(CHOWN) -R $(OCSIGENUSER):$(OCSIGENGROUP) $(TEMPROOT)$(DATADIR)
	chmod 750 $(TEMPROOT)$(DATADIR)
	$(INSTALL) -d -m 755 $(TEMPROOT)$(MANDIR)
	$(INSTALL) -m 644 files/ocsigen.1 $(TEMPROOT)$(MANDIR)
	@echo
	@echo "## Run \"make doc\" and \"make docinstall\" to build and install the ocamldoc."

logrotate:
	[ -d /etc/logrotate.d ] && \
	 { mkdir -p $(TEMPROOT)/etc/logrotate.d ; \
	   cat files/logrotate.in \
	   | sed s%LOGDIR%$(LOGDIR)%g \
	   | sed s%USER%$(OCSIGENUSER)%g \
	   | sed s%GROUP%$(OCSIGENGROUP)%g \
	   | sed s%_COMMANDPIPE_%$(COMMANDPIPE)%g \
	  > $(TEMPROOT)/etc/logrotate.d/$(OCSIGENNAME); }

dist:
	DARCS_REPO=$(PWD) darcs dist -d $(OCSIGENNAME)-$(VERSION)

.PHONY: uninstall fulluninstall
uninstall:
	-${OCAMLFIND} query ${OCSIGENNAME} \
	  && cd external/ocamlderiving \
	  && OCAMLFIND_DESTDIR=`${OCAMLFIND} query ${OCSIGENNAME}` $(MAKE) uninstall
	-rm -Rf $(TEMPROOT)$(DOCDIR)
	-rm -Rf $(TEMPROOT)$(EXTRALIBDIR)
	-rm -Rf $(TEMPROOT)$(MODULEINSTALLDIR)/$(OCSIGENNAME)/client
	-rm -Rf $(TEMPROOT)$(MODULEINSTALLDIR)/$(OCSIGENNAME)/syntax
	-$(MAKE) -C server uninstall
	-rm -Rf "$(TEMPROOT)$(MODULEINSTALLDIR)/$(OCSIGENNAME)/client"
	-$(OCAMLFIND) remove $(OCSIGENNAME) -destdir "$(TEMPROOT)$(MODULEINSTALLDIR)"

fulluninstall: uninstall
# dangerous
#	rm -f $(CONFIGDIR)/$(OCSIGENNAME).conf
#	rm -f $(LOGDIR)/$(OCSIGENNAME).log
#	rm -rf $(MODULEINSTALLDIR)
