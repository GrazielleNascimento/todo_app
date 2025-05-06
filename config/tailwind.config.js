const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        primary: '#8B5CF6', // Purple 400
        'primary-dark': '#7C3AED', // Purple 500
        'primary-light': '#A78BFA', // Purple 300
        dark: '#1e293b',
        'dark-light': '#334155',
        'dark-lighter': '#475569',
        light: '#f8fafc',
        'light-dark': '#e2e8f0',
        success: '#10b981',
        danger: '#ef4444',
        warning: '#f59e0b',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}