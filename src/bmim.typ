#import "colors.typ": *
#import "admonition.typ": *
#import "utils.typ": *

#let bmim-color-theme(name: str) = {
  if name == "blue" {
    (
      primary: bmimblue,
      secondary: bmimred,
      background: white,
      neutral-lightest: white,
    )
  } else {
    panic("Unknown color theme: " + name)
  }
}

#let bmim-theme(
  variant: "practical",
  title: none,
  type: none,
  course: none,
  authors: none,
  theme: "blue",
  lang: "de",
  size: 12pt,
  wUmitLogo: true,
  font: ("New Computer Modern Math",),
  wSol: true,
  body,
) = {
  if theme != "blue" {
    panic("Unknown color theme: " + theme)
  }
  let theme = bmim-color-theme(name: theme)

  if lang != "en" and lang != "de" {
    panic("Unknown lamguage: " + lang)
  }

  set text(lang: lang, font: font, spacing: .5em, size: size)
  set par(leading: 0.525em,  justify: true, first-line-indent: 0.55em)

  let dictSpell = (
    "en": (
      "ho": "handed out",
      "lc": "last changed",
      "sol": "with solution",
      "fig": "Fig.",
      "tab": "Tab.",
    ),
    "de": (
      "ho": "ausgegeben von",
      "lc": "zuletzt geändert",
      "sol": "mit Lösung",
      "fig": "Abb.",
      "tab": "Tab.",
    )
  )

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(supplement: dictSpell.at(lang).at("tab"), numbering: "1")
  show figure.where(kind: image): set figure(supplement: dictSpell.at(lang).at("fig"), numbering: "1")
  show figure.caption: set text(size: size)
  show figure.caption: set align(start)
  show figure.caption.where(kind: table): set align(center)

  set figure.caption(separator: [ #sym.minus ])
  show figure: fig => {
    let prefix = (
      if fig.kind == table [#dictSpell.at(lang).at("tab")]
      else if fig.kind == image [#dictSpell.at(lang).at("fig")]
      else [#fig.supplement]
    )
    let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))
    show figure.caption: it => [
      #text(weight: "bold")[
        #prefix~#numbers
      ]
      #it.separator#it.body
    ]
    show figure.caption.where(kind: table): smallcaps
    fig
  }

  set page(
    paper: "a4",
    margin: (
      left: 2cm,
      right: 2cm,
      top: 1.9cm,
      bottom: 2.5cm,
    ),
    header: [
      #pad(
        bottom: 0.25em,
        left: -2.25em,
        grid(
          columns: (5%, 13%, 62%, 20%, 5%),
          grid.cell(
            block(
              width: 100%,
              height: 1.3em,
              fill: theme.primary.lighten(20%),
              below: 0.25em,
            )
          ),
          grid.cell(
            pad(
              top: 0em,
              left: -7pt,
              move(
                dy: 3pt,
                image("./../assets/iace.svg")
              )
            )
          ),
          grid.cell(
            pad(
              left: -3pt,
              block(
                width: 100%,
                height:1.3em,
                fill: theme.primary.lighten(20%),
                below: 0.25em,
              )
            )
          ),
          grid.cell(
            pad(
              top: 0em,
              left: 4pt,
              if wUmitLogo {
                if lang == "en" {
                  move(
                    dy: 7.9pt,
                    image("./../assets/logo_umit_eng.svg", height: 2.02em)
                  )
                } else {
                  move(
                    dy: 7.9pt,
                    image("./../assets/logo_umit_de.svg", height: 2.02em)
                  )
                }
              } else {
                move(
                  dx: -0.15pt,
                  dy: 2.3pt,
                  image("./../assets/logo_umit_wo.svg", height: 1.509em)
                )
              }
            )
          ),
          grid.cell(
            block(
              width: 100%,
              height: 1.3em,
              fill: theme.primary.lighten(20%),
              below: 0.25em,
              ""
            )
          ),
        )
      )
    ],
    footer: context [
      #set text(size: 11pt)
      #line(length: 100%, stroke: 0.5pt)
      #if calc.odd(here().page()) [
        #v(-0.6em)
        #type - #course - #title #if wSol {text(bmimred)[#dictSpell.at(lang).at("sol")]}
        #h(1fr)
        #counter(page).display(
          "1",
        )
      ] else [
        #v(-0.6em)
        #counter(page).display(
          "1",
        )
        #h(1fr)
        #type  - #course - #title #if wSol {text(bmimred)[#dictSpell.at(lang).at("sol")]}
      ]
    ]
  )

  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    set heading(numbering: "1")
    set text(weight: "bold")
    set block(
      width: 100%,
      fill: theme.primary.lighten(80%),
      inset: 4pt,
    )
    if it.numbering == none [
      #block(it.body)
    ] else [
      #block(counter(heading).display(it.numbering)  + h(1em) + it.body)
    ]
  }

  show outline.entry.where(level: 1): it => {
    if it.element.func() != heading {
      return it
    }

    v(1.5em, weak: true)
    if it.prefix() == none [
      #strong(it.body() + h(1fr) + it.page())
    ] else [
      #strong(it.prefix() + h(0.5em) + it.body() + h(1fr) + it.page())
    ]
  }

  {
    set align(center)
    rect(
      width: 100%,
      radius: 0%,
      inset: (top: 0.2em, bottom: 0.2em, left: 0.2em, right: 0.2em),
      stroke: 1pt,
    )[
      #rect(
        width: 100%,
        radius: 0%,
        inset: (top: 1em, bottom: 1em),
        stroke: (paint: black.lighten(20%), thickness: 1.3pt),
      )[
      #text(
        weight: "bold",
        [
          #type \
          #sym.hyph \
          #course \ #v(-0.5em)
          #line(length: 90%) #v(-0.5em)
          #title
        ]
      )]
    ]
    grid(
      columns: (1.25fr, 1fr),
      gutter: 0.75em,
      grid.cell(
        text(
        )[
          #set align(right)
          #if wSol {text(bmimred, weight: "bold")[#dictSpell.at(lang).at("sol"),]} #dictSpell.at(lang).at("ho"):
        ]
      ),
      grid.cell(
        text(
        )[
          #set align(left)
          #grid(
            columns: (1fr,),
            column-gutter: 1em,
            row-gutter: 0.5em,
            ..authors.map(author => text(fill: black, author)),
          )
        ]
      ),
      grid.cell(
        text(
        )[
          #set align(right)
          #dictSpell.at(lang).at("lc"):
        ]
      ),
      grid.cell(
        text(
        )[
          #set align(left)
          #let curDate = datetime.today()
          #curDate.day(). #translatedMonth(curDate, lang) #curDate.year()
        ]
      ),
    )
  }

  body
}

#let backmatter(content) = {
  set heading(numbering: "A.1")
  counter(heading).update(0)
  state("backmatter").update(true)
  content
}
