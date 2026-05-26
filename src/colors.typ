#let color = (
  link: rgb(118, 50, 55),
  blue: rgb(0, 66, 104),
  darkblue: rgb(0, 58, 91),
  meanblue: rgb(0, 119, 165),
  gray: rgb(156, 156, 156),
  grey: rgb("717788"),
  green: rgb("006e43"),
  purple: rgb("55488e"),
  red: rgb("961842"),
  yellow: rgb("b98900"),
)

#let color-theme = (
  blue:
  (
    primary: color.blue,
    highlight: color.darkblue,
    lolight: color.blue.lighten(80%),
    meanlight: color.meanblue,
    secondary: color.red,
    background: white,
    neutral-lightest: white,
  )
)

