#import "colors.typ": *
#import "data.typ": *

#let options = state("bmim-options", (
  theme: color-theme.blue,
  lang: "de", // "de", "en"
  spell: i18n.de,
  logo-with-text: false,
  show-solution: none, // none, inline, bottom
  task-show: (counter, points, task) => context [
    #let hdrnum = query(heading.where(level:1, outlined: false).before(here())).len()
    #if heading.numbering != none [
    = Aufgabe #hdrnum.#counter <bmim:nonumber>
  ] else [
    = Aufgabe #counter #h(1fr) Punkte: #points <bmim:nonumber>
  ]
    #set math.equation(numbering: "(1)")//, supplement: none)
    #task
  ],
  task-show-solution: solution => {
    let blocked(it) = {
      block(
        width: 100%,
        fill: color.red.lighten(0%),
        inset: 2pt,
        breakable: true,
        box(
          stroke: 0.5pt,
          width: 100%,
          fill: white,
          inset: 0.3em,
          it,
        ),
      )
    }
    for s in solution {
    blocked[
      *Lösung:*

      #s
    ]
  }
  },
  font: ("New Computer Modern",),
  size: 12pt,
))

#let option-set(dict) = {
  options.update(o => {
    for (key, val) in dict {
      if key not in o {
        let known = o.keys().filter(k => k != "spell")
        panic(
          "Unknown option: "+ key +
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
