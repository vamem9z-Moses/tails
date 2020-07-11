watch-app:
	npx shadow-cljs watch app

server-repl:
	clj -A:clj-1.10.1:clj-server:clj-server-test:dev:cider-clj

server-test:
	clj -A:clj-1.10.1:clj-server:clj-server-test

# cljs repl - not embedded in the app
cljs-app-repl:
	clj -A:clj-1.10.1:cljs-1.10.758:cljs-app:dev:cljs-dev:cider-cljs

check-clj-outdated:
	-clj -A:clj-1.10.1:outdated

check-npm-outdated:
	npm outdated

check-outdated: check-clj-outdated check-npm-outdated