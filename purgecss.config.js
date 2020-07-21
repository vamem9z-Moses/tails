module.exports = {
    content: ["src/**/*.cljs"],
    css: ["resources/public/css/styles.css"],
    defaultExtractor: (content) => content.match(/[\w-/.:]+(?<!:)/g) || [],
  };