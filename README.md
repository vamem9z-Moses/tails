# tails

tails is a template for building apps with a clojurescript SPA and clojure server.
I've liberally borrowed from Michael McClintock's  [tailwind-css shadow-cljs example](https://github.com/mrmcc3/tailwind-cljs-example/tree/master/shadow-cljs). This was born out of
my need to understand the leiningen configuration created by [Luminus](https://luminusweb.com/).
I'm extremely grateful for Luminus because it helped me to get started without
having to learn the much about clojure's build systems.  However, as I became more
comfortable with the ecosystem, I found myself really struggling to decipher everything
included in the project.clj that the template provided.  Ultimately, I wanted a build
system that was composable and simple like the rest of my clojure code.

Of course this was a challenge because I needed to incorporate html and css handling
while embracing  the javascript ecosystem. This led me to the following setup:

1. tools.deps and deps.edn with liberal use of aliases to manage clojure and clojurscript dependies

2. shadow-cljs to manage javascript builds

3. tailwindcss, purgecss and cleancss to manage css builds

4. and, make to tie it all together. I think of make as the ui for the build system. It's tasks are written as composable functions.

I selected tailwindcss as the css framework because of its embace of functional css.
As someone who has done some frontend javascript, but is not an expert by any means,
I like the idea of building the frontend using the same mental approaches as
the rest of the application.

## Getting started

### Requirements

1. NodeJS and npm

1. Make

1. Clojure CLI

Once the requirements are installed, run the bootstrap task `make bootstrap`.
This will install all of the necessary libraries. Once they are installed run
`make watch-app`, which will start-up the frontend application.  I didn't add a
clojure server, but there is a basic backend that can be started in a repl with
the command `make server-repl`.
