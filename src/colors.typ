#let color = (
  red: rgb(128, 19, 50),
  green: rgb(0, 92, 100),
  light_green: rgb(115, 167, 156),
  blue: rgb(0, 53, 103),
  purple: rgb(85, 25, 95),
  gold: rgb(171, 141, 37),
  light_gold: rgb(200, 183, 118),
  light_gray: rgb(217, 218, 219),
  gray: rgb(143, 143, 141),
  dark_gray: rgb(90, 79, 74),
  link: rgb(118, 50, 55),
  grey: rgb("717788"),
  yellow: rgb("b98900"),
)

#let color-theme = (
  blue:
  (
    primary: color.blue,
    secondary: color.green,
    tertiary: color.red,
    highlight: color.gold,
    lolight: color.light_gold,
    // lolight: color.light_green,
    background: white,
    neutral: color.gray,
    neutral-lightest: color.light_gray,
    neutral-darkest: color.dark_gray,
  )
)

