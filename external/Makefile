
# the order matters
MAKESUBDIRS=\
 ocamlpcre ocamlcalendar ocamlcryptokit ocamltext \
 ocamlnet \
 ocamlssl ocamlreact \
 ocamllwt \
 ocamlcsv \
 ocamlextlib \
 ocamlderiving \
 ocamlcairo


clean:
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i clean || exit 1; done
	rm -rf ocamlcalendar/target/

