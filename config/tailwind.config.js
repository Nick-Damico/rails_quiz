const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
      keyframes: {
        fadeOut: {
          from: { opacity: 1 },
          to: { opacity: 0 },
        },
        ratingSlideIn: {
          "0%": { transfrom: "translateY(0)" },
          "66%": { transform: "translateY(142px)" },
          "100%": { transform: "translateY(130px)" },
        },
        ratingSlideOut: {
          "0%": { transform: "translateY(130px)" },
          "33%": { transform: "translateY(142px)" },
          "100%": { transform: "translateY(0)" },
        },
      },
      animation: {
        fadeOut: "fadeOut 0.6s ease-in forwards",
        "rating-slide-in": "ratingSlideIn 0.6s ease-in forwards",
        "rating-slide-out": "ratingSlideOut 0.6s ease-in forwards",
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
  safelist: [
    "group-[.is-active]:bg-emerald-500",
    {
      pattern: /border-(red|green|blue)-(100|200|300)/
    },
  ]
};
