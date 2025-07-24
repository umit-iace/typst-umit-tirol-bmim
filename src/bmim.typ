#import "@preview/oxifmt:0.2.1": strfmt
#import "colors.typ": *
#import "admonition.typ": *
#import "list.typ": *
#import "task.typ": *
#import "utils.typ": *

#let task-with-sol = state("bmim-tasks-with-sol", false)
#let task-with-points = state("bmim-tasks-with-points", false)

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
  with-solution: true,
  with-points: true,
  body,
) = {
  if theme != "blue" {
    panic("Unknown color theme: " + theme)
  }
  let theme = bmim-color-theme(name: theme)

  if lang != "en" and lang != "de" {
    panic("Unknown lamguage: " + lang)
  }
  task-with-sol.update(with-solution)
  task-with-points.update(with-points)

  set text(lang: lang, font: font, spacing: .5em, size: size)
  set par(leading: 0.55em, spacing: 0.55em, justify: true)
  show raw: set text(font: "CMU Typewriter Text", size: size)

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

  show ref: it => {
    let el = it.element
    if el != none and el.func() == metadata and el == enum-label-mark {
      let supp = it.supplement
      if supp == auto {
        supp = dictSpell.at(lang).at("item")
      }
      // get the counter value in the correct format according to location
      let loc = el.location()
      let num = enum-numbering-state.at(loc)
      if std.type(enum-numbering-state.at(loc)) != str {
        num = enum-numbering-state.at(loc).with(loc:loc)
      }
      let ref-counter = numbering(num, ..enum-counter.at(loc))
      if is-empty(supp) {
        link(el.location(), ref-counter)
      }
      else {
        link(el.location(), box([#supp~#ref-counter]))
      }
    } else {
      it
    }
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
          columns: (5%, 13%, 61.25%, 21.1%, 5%),
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
                    dy: 8.6pt,
                    image("./../assets/logo_umit_eng.svg", height: 2.02em)
                  )
                } else {
                  move(
                    dy: 8.6pt,
                    image("./../assets/logo_umit_de.svg", height: 2.02em)
                  )
                }
              } else {
                move(
                  dx: -0.15pt,
                  dy: 2.5pt,
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
    footer: if variant == "practical" {
      context [
        #set text(size: 11pt)
        #line(length: 100%, stroke: 0.5pt)
        #if calc.odd(here().page()) [
          #type - #course - #title #if with-solution {text(bmimred)[#dictSpell.at(lang).at("with") #dictSpell.at(lang).at("sol")]}
          #h(1fr)
          #counter(page).display(
            "1",
          )
        ] else [
          #counter(page).display(
            "1",
          )
          #h(1fr)
          #type - #course - #title #if with-solution {text(bmimred)[#dictSpell.at(lang).at("with") #dictSpell.at(lang).at("sol")]}
        ]
      ]
    } else if variant == "exam" {
      context [
        #set text(size: 11pt)
        #line(length: 100%, stroke: 0.5pt)
        #if calc.odd(here().page()) [
          #type - #course #if with-solution {text(bmimred)[#dictSpell.at(lang).at("with") #dictSpell.at(lang).at("sol")]}
          #h(1fr)
          #counter(page).display(
            "1/1",
            both: true,
          )
        ] else [
          #counter(page).display(
            "1/1",
            both: true,
          )
          #h(1fr)
          #type - #course #if with-solution {text(bmimred)[#dictSpell.at(lang).at("with") #dictSpell.at(lang).at("sol")]}
        ]
      ]
    }
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
  show heading.where(label: <bmim:nonumber>): set heading(numbering: none, outlined: false)

  // ### Outline
  set outline(depth: 2)
  set outline.entry(fill: repeat[.~])

  show outline.entry.where(level: 1): it => {
    if it.element.func() != heading {
      return it
    }

    set block(above:1em)
    strong(link(
      it.element.location(),
      it.indented(it.prefix(), {it.body(); h(1fr); it.page()}),
    ))
  }
  // ###

  {
    set align(center)
    if variant == "practical" {
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
            #course \
            #line(length: 90%)
            #title
          ]
        )]
      ]
    } else if variant == "exam" {
      text(
        weight: "bold",
        [
          #type - #course
        ]
      )
    }
    grid(
      columns: (1.25fr, 1fr),
      gutter: 0.75em,
      grid.cell(
        text(
        )[
          #set align(right)
          #if with-solution {text(bmimred, weight: "bold")[#dictSpell.at(lang).at("with") #dictSpell.at(lang).at("sol"),]} #dictSpell.at(lang).at("ho"):
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

  context {
    if task-with-points.get() {
      let tasks-points = state("bmim-tasks-points", ()).final()
      let col-num = range(0, tasks-points.len() + 2)

      let header-row = col-num.map(n => {
          if n == tasks-points.len() {text(hyphenate: false)[$Sigma$]}
          else if n == tasks-points.len() + 1 {text(hyphenate: false)[#dictSpell.at(lang).at("mark")]}
          else [ A#(n+1) ]
        }
      )

      let point-row = col-num.map(n => {
          if n == tasks-points.len() {text(hyphenate: false, context tasks-points.sum())}
          else if n < tasks-points.len() {
            let point = tasks-points.at(n)
            [
              #strfmt("{0}", calc.round(point, digits: 2), fmt-decimal-separator: ".")
            ]
          }
        }
      )
      let empty-row = col-num.map(n => {[]})

      show table.cell.where(y: 0): strong
      set table(
        align: (x, y) => (
          if x >= 0 { center }
          else { left }
        )
      )
      rect(
        width: 100%,
        radius: 0%,
        inset: (top: 0.5em, bottom: 0.5em, left: 0.5em, right: 0.5em),
        stroke: 0.5pt,
      )[
        #text(weight: "bold")[#dictSpell.at(lang).at("eval")]
        #align(center, table(
          columns: col-num.map( n => {1fr}),
          table.header(
            ..header-row,
          ),
          rows: (auto, auto, 2em),
          ..point-row,
          ..empty-row
          )
        )
    ]
    }
  }

  {
    if variant == "exam" {
      rect(
        width: 100%,
        radius: 0%,
        inset: (top: 1em, bottom: 1em),
        stroke: (paint: black.lighten(20%), thickness: 1.3pt),
      )[
      #text(
        weight: "bold",
        [
          Hinweise
        ]
      )]
    }
  }

  body

}
