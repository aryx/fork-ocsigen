
# the order matters
MAKESUBDIRS= ocamlpcre ocamlcalendar ocamlcryptokit ocamltext \
 ocamlnet \
 ocamlssl ocamlreact \
 ocamllwt \
 ocamlderiving \
 ocamlcsv \
 ocamlextlib \


clean:
	set -e; for i in $(MAKESUBDIRS); do $(MAKE) -C $$i clean || exit 1; done
	rm -rf ocamlderiving/tmp/
	rm -rf ocamlcalendar/target/

