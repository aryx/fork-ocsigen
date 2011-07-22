MAKESUBDIRS= pgocaml macaque

clean:
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i clean || exit 1; done
