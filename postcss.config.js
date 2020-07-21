module.exports = {
    plugins: [
        require('tailwindcss'),
        require('autoprefixer'),
        require('@fullhuman/postcss-purgecss')({
            content: ['./src/**/*.cljs'],
            defaultExtractor: (content) => content.match(/[\w-/.:]+(?<!:)/g) || [],
        })
    ]
}