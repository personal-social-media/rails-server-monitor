module.exports = {
  mode: 'jit',
  purge: {
    content: [
      './app/javascript/**/*.jsx',
      './app/javascript/**/*.js',
      './app/**/*.html.erb',
      './app/components/**/*.rb',
    ],
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
