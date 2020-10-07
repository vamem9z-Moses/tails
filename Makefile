public = build/public

# setup tasks
bootstrap:
	npm install 

# server tasks
server-test:
	clj -M:clj-1.10.1:clj-server:clj-cljs:dev-clj:test-clj -m cognitect.test-runner

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

postcss: 
	npx postcss resources/src/css/styles.css -o ${public}/css/styles.css

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
watch-css: tailwind-css

watch-shadow-app: copy-html
	npx shadow-cljs watch app

watch-app: purge-build-dir watch-css watch-shadow-app

cljs-repl: watch-app

server-repl:
	clj -M:clj-1.10.1:clj-server:test-clj:clj-cljs:dev:dev-clj:cider-clj -m nrepl.cmdline -p 7002 --middleware "[cider.nrepl/cider-middleware]"

# release tasks
release-server:
	clj -M:clj-1.10.1:clj-server:depstar -m hf.depstar.jar build/server/workman.jar

release-css: postcss clean-css

release-shadow-app:
	npx shadow-cljs release app

release-app: purge-build-dir create-build-dirs copy-static-assets release-css release-shadow-app sanitize-build

release-all: release-server release-app

# task to check to see if libraries in use are outdated
## the "-" allows make to ignore warning caused by Java 11
check-clj-outdated:
	-clj -M:clj-logger:clj-1.10.1:outdated -m antq.core

check-npm-outdated:
	npm outdated

check-outdated: check-clj-outdated check-npm-outdated