#import "@preview/oxifmt:0.2.1": strfmt
#import "colors.typ": *
#import "admonition.typ": *
#import "list.typ": *
#import "task.typ": *
#import "utils.typ": *
#import "layout.typ": *

#let task-with-sol = state("bmim-tasks-with-sol", false)
#let task-with-points = state("bmim-tasks-with-points", false)
#let task-sol-at-end = state("bmim-tasks-sol-at-end", false)
#let nonumber-cnt = counter("bmim-nonumber")

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
  course-short: none,
  authors: none,
  theme: "blue",
  lang: "de",
  size: 12pt,
  date: datetime.today(),
  wUmitLogo: true,
  font: ("New Computer Modern Math",),
  with-solution: true,
  sol-at-end: false,
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
  task-sol-at-end.update(sol-at-end)

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
    header: header-general(theme, wUmitLogo, lang),
    footer: if variant == "practical" {
      footer-practical(type, course, title, with-solution, lang)
    } else if variant == "exam" {
      footer-exam(type, course-short, title, with-solution, lang)
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
  show heading.where(label: <bmim:nonumber>): it => {
    set heading(numbering: none, outlined: false)
    set block(
      width: 100%,
      fill: theme.primary.lighten(80%),
      inset: 4pt,
    )
    nonumber-cnt.step()
    block(it.body)
  }

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

  // ### Title
  {
    set align(center)
    if variant == "practical" {
      title-practical(type, course, title)
      subtitle-practical(authors, with-solution, lang)
    } else if variant == "exam" {
      title-exam(type, course)
      subtitle-exam(authors, date, lang)
    }
  }
  // ###

  // ### Evaluation
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
  // ###

  // ### Notes
  {
    if variant == "exam" {
      notes-exam()
    }
  }
  // ###

  body

  // ### Seperate Solutions for Exam
  context {
    if task-with-sol.get() and task-sol-at-end.get() {
      let tt = text[#dictSpell.at(lang).at("sol")].text
      block[
        = #upper(tt.first())#tt.slice(1) <bmim:nonumber>
      ]
      show-task-sol()
    }
  }

}
