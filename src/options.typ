#import "colors.typ": *
#import "data.typ": *

#let options = state("bmim-options", (
  theme: color-theme.blue,
  lang: "de", // "de", "en"
  spell: i18n.de,
  logo-with-text: false,
  show-solution: none, // none, inline, bottom
  task-show: none,
  font: ("New Computer Modern",),
  size: 12pt,
))

#let option-set(dict) = {
  options.update(o => {
    for (key, val) in dict {
      if key not in o {
        let known = o.keys().filter(k => k != "spell")
        panic(
          "Unknown option: " + key +
          ". Known options: " + known.join(", ")
        )
      }
      if key == "lang" {
        o.lang = val
        o.spell = i18n.at(val)
      } else {
        o.at(key) = val
      }
    }
    return o
  })
}
