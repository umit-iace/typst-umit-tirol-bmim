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
  font: ("Source Serif 4",),
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
      if key == "lang" {
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
