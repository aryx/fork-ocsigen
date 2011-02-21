include ../Makefile.config

NAME=$(OCSIGENNAME)

FILES= ocsigen_extensions.ml ocsigen_parseconfig.ml ocsigen_http_client.ml \
	../extensions/ocsigen_LocalFiles.ml ocsigen_server.ml
EXE= server_main.ml


ifeq "$(BYTECODE)" "YES"
INSTALLBYTE=installbyte
else
INSTALLBYTE=
endif

ifeq "$(NATIVECODE)" "YES"
INSTALLOPT=installopt
else
INSTALLOPT=
endif

ifeq "$(NATDYNLINK)" "YES"
DYNLINK=dynlink,
else
DYNLINK=
endif

CMAOCAMLP4= camlp4lib.cma Camlp4OCamlRevisedParser.cmo Camlp4OCamlParser.cmo
CMXXACAMLP4= camlp4lib.cmxa Camlp4OCamlRevisedParser.cmx Camlp4OCamlParser.cmx
LIBDIRS := $(LIBDIRS) -I +camlp4 -I +camlp4/Camlp4Parsers

export OCAMLPATH := ../deriving/tmp:${OCAMLPATH}

INSTALL = install
CAMLC = $(OCAMLFIND) $(CAMLCNAME2) $(DBG) -package dynlink $(LIB)
CAMLOPT = $(OCAMLFIND) $(CAMLOPTNAME) $(DBG) $(LIB)
CAMLDOC = $(OCAMLFIND) ocamldoc $(LIB)
CAMLDEP = $(OCAMLFIND) ocamldep $(LIBDIRS)
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
PACKAGE = lwt.ssl,lwt.extra,netstring,$(NETSYS)ssl,pcre,unix,$(DYNLINK)threads,findlib,cryptokit,deriving
LIB = -thread -package ${PACKAGE} $(LIBDIRS)
# also modify builtin_package in lib/ocsigen_config.ml.in if you modify the former line!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# and probably also in the list of dependencies of ocsigen.cma in the META.in file
PP = 
PP2 = 

ifdef DONOTPARSECOMMANDLINE
PARSECOMMANDLINECMA=../lib/donotparsecommandline.cma
else
PARSECOMMANDLINECMA=../lib/parsecommandline.cma
endif
PARSECOMMANDLINECMXA=$(PARSECOMMANDLINECMA:.cma=.cmxa)

# cma and cmo to be linked in the server:

#pad: should use some .cma ... ugly all those set of object files
CMOS = ../lib/ocsigen_lib_cli.cmo \
       ../lib/ocsigen_cache.cmo \
       ../lib/ocsigen_lib.cmo \
       ../web_html/xmllexer.cmo ../web_html/simplexmlparser.cmo \
       ../lib/ocsigen_config.cmo \
       ../lib/ocsigen_commandline.cmo \
       ../lib/ocsigen_messages.cmo \
       ../lib/dynlink_wrapper.cmo ../lib/ocsigen_loader.cmo \
       ../lib/ocsigen_stream.cmo ../http/multipart.cmo \
       ../http/http_headers.cmo ../http/ocsigen_cookies.cmo \
       ../http/ocsigen_http_frame.cmo ../http/ocsigen_headers.cmo \
       ../http/ocsigen_range.cmo \
       ../http/http_lexer.cmo ../http/http_parser.cmo \
       ../http/framepp.cmo ../http/ocsigen_http_com.cmo \
       ../web_html/xhtml_mkcompact_streams.cmo ../web_html/xhtmlcompact_streams.cmo \
       ../web_html/xhtml_mkpretty_streams.cmo ../web_html/xhtmlpretty_streams.cmo \
       ../web_html/xhtml5pretty_streams.cmo ../web_html/xhtml5compact_streams.cmo\
       ../http/ocsigen_charset_mime.cmo ../http/ocsigen_senders.cmo \
       ../lib/polytables.cmo
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! also modify builtin_package in ocsigen_config.ml if you modify the former line!
CMAO = ../web_html/xhtml.cma ../web_html/xhtmlpretty.cma $(NAME).cma

STUBS_OBJS = stubs.o

OBJS = $(FILES:.ml=.cmo) $(DUCEFILES:.ml=.cmo)
OBJSEXE = $(EXE:.ml=.cmo)

CMXSATEMP=$(CMOS:.cmo=.cmx)
CMXSA=$(CMXSATEMP:.cma=.cmxa)
CMXXATEMP=$(CMAO:.cmo=.cmx)
CMXXA=$(CMXXATEMP:.cma=.cmxa)

OBJSOPT = $(FILES:.ml=.cmx) $(DUCEFILES:.ml=.cmx)
OBJSEXEOPT = $(EXE:.ml=.cmx)


byte: $(OBJS) $(OBJSEXE) $(NAME)

opt: $(OBJSOPT) $(OBJSEXEOPT) $(NAME).opt


.SUFFIXES:
.SUFFIXES: .ml .mli .cmo .cmi .cmx

.PHONY: doc depend

$(NAME): $(CMAO) $(OBJSEXE) $(PARSECOMMANDLINECMO)
	$(CAMLC) -o $(NAME) -linkpkg -linkall $(PARSECOMMANDLINECMA) $(CMAOCAMLP4) $(CMAO) $(OBJSEXE)

$(NAME).opt: $(CMXXA) $(OBJSEXEOPT) $(PARSECOMMANDLINECMX)
	$(CAMLOPT) -o $(NAME).opt -linkpkg -linkall $(PARSECOMMANDLINECMXA) $(CMXXACAMLP4) $(CMXXA) $(OBJSEXEOPT)

$(NAME).cma: $(CMOS) $(OBJS) $(STUBS_OBJS)
	$(CAMLMKLIB) -o $(NAME) -oc $(NAME) -linkall $(CMOS) $(OBJS) $(STUBS_OBJS)

$(NAME).cmxa: $(CMXSA) $(OBJSOPT) $(STUBS_OBJS)
	$(CAMLMKLIB) -o $(NAME) -oc $(NAME) -linkall $(CMXSA) $(OBJSOPT) $(STUBS_OBJS)

.ml.cmo:
	$(CAMLC) $(PP) -c $<

.mli.cmi:
	$(CAMLC) -c $<

.ml.cmx:
	$(CAMLOPT) $(PP) -c $<

top: .ocamlinit
	OCAMLPATH=${SRC}/files/:${OCAMLPATH} ${RLWRAP} ocaml

.ocamlinit: ../Makefile.config
	echo "#use \"topfind\";;" > $@
	echo "#camlp4o;;" >> $@
	echo "#thread;;" >> $@
	echo "#require \"ocsigen.server\";;" >> $@
	echo "#require \"ocsigen.deriving.syntax\";;" >> $@

#doc:
#	$(CAMLDOC) -d doc -html eliom.mli ocsigen.mli ocsigen_extensions.mli


stubs.o: stubs.c
	$(CAMLC) $(CAMLINCLUDE) -c $<

.PHONY: clean
clean:
	-rm -f *.cm[aiox] *.cmxa *.cmxs *.o *.a *~ doc/* $(NAME) $(NAME).opt $(NAME)top *.annot *.so

.PHONY: install
install: install_so $(INSTALLBYTE) $(INSTALLOPT)

install_so:
	@echo "Installing shared stubs"
	mkdir -p $(TEMPROOT)$(STUBDIR)
	$(INSTALL) -m 755 dll$(NAME).so $(TEMPROOT)$(STUBDIR)/

installbyte:
	@echo "Installing bytecode server"
	mkdir -p $(TEMPROOT)$(BINDIR)
	$(INSTALL) -m 755 $(NAME) $(TEMPROOT)$(BINDIR)/

installopt:
	@echo "Installing native server"
	mkdir -p $(TEMPROOT)$(BINDIR)
	[ -f $(NAME).opt ] && $(INSTALL) -m 755 $(NAME).opt $(TEMPROOT)$(BINDIR)/

.PHONY: uninstall
uninstall:
	rm -f $(TEMPROOT)$(BINDIR)/$(NAME)
	rm -f $(TEMPROOT)$(BINDIR)/$(NAME).opt
	rm -f $(TEMPROOT)$(STUBDIR)/dll$(NAME).so

depend:
	$(CAMLDEP) $(LIBDIRS) $(PP2) $(FILES:.ml=.mli) $(EXE:.ml=.mli) $(FILES) $(EXE) $(DUCEFILES:.ml=.mli) $(DUCEFILES) > .depend


FORCE:

-include .depend


