all:
	./build

install:
	cp -f src/META _build/src/
	cd _build/src/; ocamlfind install  react META react.ml* react.cm* react.o

clean:
	./build clean
