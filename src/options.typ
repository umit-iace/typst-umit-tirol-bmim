#import "colors.typ": *
#import "data.typ": *
#import "check.typ": *

#let options = state("bmim-options", (
  theme: color-theme.cd26,
  lang: "de", // "de", "en"
  spell: i18n.de,
  show-solution: none, // none, "inline", "bottom"
  task-show: (..args) => {},
  task-show-points: false,
  task-wrap-counter: none,
  font: auto, // auto (= fonts.serif, slides: fonts.sans) or font name(s)
  fonts: (
    serif: "Source Serif 4", // body text
    sans: "Source Sans 3", // slides, abstract
    mono: "Source Code Pro", // code
    letter: "Bitstream Vera Sans", // letter, free font that looks like Arial
    logo: "Nimbus Sans", // text next to the LFUI logo
  ),
  size: 11pt,
  logo: auto, // none, auto, (left: // , right: //)
  titleblock: auto, // none, auto, function
  oneside: true
))

#let option-set(dict) = {
  options.update(o => {
    for (key, val) in dict {
      let known = o.keys().filter(k => k != "spell")
      assert(key in known, message:
        "Unknown option '" + key + "', known options are [" +
        known.map(repr).join(", ") + "]"
      )
      if key == "fonts" {
        // only the given fonts are replaced, the others keep their defaults
        for font-key in val.keys() {
          assert(font-key in o.fonts, message:
            "Unknown font '" + font-key + "', known fonts are [" +
            o.fonts.keys().map(repr).join(", ") + "]"
          )
        }
        o.fonts += val
      } else if key == "lang" {
        assert-one-of("lang", val, i18n.keys())
        o.lang = val
        o.spell = i18n.at(val)
      } else {
        o.at(key) = val
      }
      if key == "show-solution" {
        assert-one-of("show-solution", val, (none, "inline", "bottom"))
      }
    }
    return o
  })
}

// Main text font: the `font` option, or the given role of `fonts` for auto.
#let main-font(opts, role: "serif") = if opts.font == auto {
  opts.fonts.at(role)
} else {
  opts.font
}
