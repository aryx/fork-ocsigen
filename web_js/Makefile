# the order matters
MAKESUBDIRS= js_of_ocaml oclosure

clean:
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i clean || exit 1; done
