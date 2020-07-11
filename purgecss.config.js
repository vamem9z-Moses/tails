module.exports = {
    content: ["src/**/*.cljs"],
    css: ["resources/public/css/app.css"],
    defaultExtractor: (content) => content.match(/[\w-/.:]+(?<!:)/g) || [],
  };