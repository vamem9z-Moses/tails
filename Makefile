
public = build/public

# setup tasks
bootstrap:
	npx install 

# server tasks
server-test:
	clj -A:clj-1.10.1:clj-server:clj-server-test

# cljs app tasks
app-test:
	npx shadow-cljs test app

# copy static assests tasks
copy-html:
	cp resources/src/index.html ${public}/

copy-static-assets: copy-html

# css tasks
tailwind-css:
	npx tailwind build resources/src/css/styles.css -o ${public}/css/styles.css

purge-css:
	npx purgecss -c purgecss.config.js -o ${public}/css

clean-css:
	npx cleancss -o ${public}/css/styles.css ${public}/css/styles.css

# File tasks
sanitize-build:
	rm -rf ${public}/js/cljs-runtime ${public}/js/manifest.edn

purge-build-dir:
	rm -rf build/

create-build-dirs:
	mkdir -p ${public}

# dev tasks
## cljs repl - not embedded in the app
cljs-app-repl:
	clj -A:clj-1.10.1:cljs-1.10.758:cljs-app:dev:cljs-dev:cider-cljs

server-repl:
	clj -A:clj-1.10.1:clj-server:clj-server-test:dev:cider-clj

watch-css: tailwind-css

watch-shadow-app: copy-html
	npx shadow-cljs watch app

## starts an embedded repl
watch-app: purge-build-dir watch-css watch-shadow-app

# release tasks
release-server:
	clj -A:clj-1.10.1:clj-server:depstar

release-css: tailwind-css purge-css clean-css

release-shadow-app:
	npx shadow-clsj release app

release-app: release-css release-shadow-app sanitize-build

release-all: purge-build release-server release-app

# task to check to see if libraries in use are outdated
## the "-" allows make to ignore warning caused by Java 11
check-clj-outdated:
	-clj -A:clj-1.10.1:outdated

check-npm-outdated:
	npm outdated

check-outdated: check-clj-outdated check-npm-outdated