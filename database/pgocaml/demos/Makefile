PROJECT=project

LINK_PKG=pgocaml 
COMP_PKG=pgocaml,pgocaml.syntax

all: $(PROJECT)

clean:: 
	rm -f $(PROJECT)

$(PROJECT): $(PROJECT).cmo
	ocamlfind ocamlc -dtypes -package $(LINK_PKG) -linkpkg -o $@ $<

$(PROJECT).cmo: $(PROJECT).ml
	ocamlfind ocamlc -dtypes -package $(COMP_PKG) -syntax camlp4o -c $<

clean::
	rm -f *.cm* *.annot
