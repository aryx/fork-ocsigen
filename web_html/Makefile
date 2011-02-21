include ../Makefile.config

byte:
	$(MAKE) -C xhtml byte
	$(MAKE) -C syntax byte
	$(MAKE) -C xml-pretty byte

opt: 
	$(MAKE) -C xhtml opt
	$(MAKE) -C syntax opt
	$(MAKE) -C xml-pretty opt

clean: 
	rm *cm* *.o -f *.a
	$(MAKE) -C xhtml clean
	$(MAKE) -C syntax clean
	$(MAKE) -C xml-pretty clean

depend: 
	$(MAKE) -C xhtml depend
	$(MAKE) -C syntax depend
	$(MAKE) -C xml-pretty depend

web_htmlpre.byte:
	$(MAKE) -C xhtml byte
	$(MAKE) -C syntax byte
	$(MAKE) -C syntax predep
web_htmlpre.opt: 
	$(MAKE) -C xhtml byte
	$(MAKE) -C syntax byte
	$(MAKE) -C syntax predep