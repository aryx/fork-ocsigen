
all:
	eliomc  -c -noinfer app.eliom
	eliomc  -a -o var/app.cma _server/app.cmo
	eliomc  -infer app.eliom
	js_of_eliom -c app.eliom
	js_of_eliom -o var/static/app.js _client/app.cmo

run:
	ocsigenserver -c ocsigen.conf


clean:
	rm -rf _client _server
