/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {},
    colors: {
      gray: {
        200: '#CECECE',
        400: '#939393',
        600: '#686868',
        800: '#4D4D4D',
      },
      white: '#FFFFFF',
    },
    fontWeight: '500',
    fontSize: '20px',
  },
  plugins: [],
}
