// #import "@preview/oxifmt:0.2.1": strfmt
#import "colors.typ": *
#import "utils.typ": *
#import "layout.typ": *
#import "list.typ": *
#import "options.typ": *
#import "taskit.typ": task, task-solutions, task-show-table

#let item-cnt = counter("item-counter")


#let bmim-common(body) = context {
  let opts = options.final()
  set text(
    lang: opts.lang,
    font: opts.font,
    spacing: .5em,
    size: opts.size,
  )
  set par(leading: 0.55em, spacing: 0.55em, justify: true)
  set page(
    margin: (
      left: 2cm,
      right: 2cm,
      top: 1.9cm,
      bottom: 2.5cm,
    ),
  )
  show raw: set text(font: "CMU Typewriter Text", size: opts.size)

  show figure.where(kind: table): set figure(supplement: opts.spell.tab)
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    show figure.caption: smallcaps
    show figure.caption: set align(center)
    it
  }
  show figure.where(kind: image): set figure(supplement: opts.spell.fig)
  show figure.where(kind: image): it => {
    show figure.caption: set align(start)
    it
  }
  set figure(numbering: "1")
  show figure: fig => {
    show figure.caption: cap => context [
      #let n = numbering(cap.numbering, ..cap.counter.at(fig.location()))
      *#cap.supplement~#n*~#sym.minus~#cap.body
    ]
    fig
  }

  show ref: it => {
    let el = it.element
    if el != none and el.func() == metadata and el == enum-label-mark {
      let supp = it.supplement
      if supp == auto {
        supp = opts.spell.item
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

  show enum: it => {
    if it.start != 0 { return it }
    let args = it.fields()
    let items = args.remove("children")
    context enum(..args, start: item-cnt.get().first() + 1, ..items)
    item-cnt.update(i => i + it.children.len())
  }


  set heading(numbering: "1.1")
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

  body
}

#let bmim-report(
  title: none,
  course: none, // either [Course Name] , or ([Course Name], [short name])
  authors: none,
  date: datetime.today(),
  ..chosen, // other options: theme, logo-with-text
) = { body => {
  option-set(chosen.named())
  show: bmim-common
  set heading(numbering: none)
  set page(
    columns: 2,
    header: header-colored(),
    footer: (footer.report)(course, title),
  )

  show heading.where(level: 2): set text(weight: "light", size: size)
  show heading.where(level: 2): emph

  (titleblock.report)(course, title, authors, date)

  body
}}

#let bmim-poster(
  title: none,
  authors: none,
  page: "a2",
  orientation: "landscape", // portrait
  date: datetime.today(),
  event: none,
  location: none,
  contact: none,
  ..chosen
) = { body => {
  option-set(
    chosen.named()
    + if "size" not in chosen.named() { (size: 20pt) }
  )
  show: bmim-common

  let margin = (x: 1.5em, y: 4em)
  set std.page(
    paper: page,
    columns: if orientation == "landscape" { 3 } else { 2 },
    flipped: orientation == "landscape",
    margin: margin,
    header: header-colored(),
    footer: (footer.poster)(event,date,location,contact),
  )

  set heading(numbering: "1.")

  (titleblock.poster)(title, authors)

  body
}}

#let bmim-exam(
  course: none,
  title: none,
  authors: none,
  date: datetime.today(),
  total-time: none,
  ..chosen
) = { body => {
  option-set(
    chosen.named()
  )
  show: bmim-common

  set std.page(
    header: (header.exam)(course, title),
  )

  set heading(numbering: "1.")
  show heading.where(level: 1): it => context {
    let opts = options.final()
    set block(
      width: 100%,
      fill: opts.theme.lolight,
      inset: 4pt,
    )
    if it.numbering == none [
      #block(it.body)
    ] else [
      #block(counter(heading).display(it.numbering)  + h(1em) + it.body)
    ]
  }

  (titleblock.exam)(course, title, authors, date, total-time)

  body

  pagebreak(weak:true)
  task-solutions
}}

#let bmim-lab(
  title: none,
  course: none,
  authors: none,
  date: datetime.today(),
  ..chosen,
) = { body => {
  option-set(
    chosen.named()
  )
  show: bmim-common

  set std.page(
    header: (header.lab)(course, title),
    footer: (footer.lab)(course, title),
  )

  set heading(numbering: "1.")
  show heading.where(level: 1): it => context {
    let opts = options.final()
    set block(
      width: 100%,
      fill: opts.theme.lolight,
      inset: 4pt,
    )
    if it.numbering == none [
      #block(it.body)
    ] else [
      #block(counter(heading).display(it.numbering)  + h(1em) + it.body)
    ]
  }

  (titleblock.lab)(course, title, authors, date)

  body

  pagebreak(weak:true)
  task-solutions
}}


// #let bmim(
//   variant: "exam", // "exam", "lab", "workbook", "slides", "poster", "report"
//   title: none,
//   course: none, // either [Course Name] , or ([Course Name], [short name])
//   authors: none,
//   lang: "de",
//   size: 12pt,
//   date: datetime.today(),
//   font: ("New Computer Modern",),
//   solution: none, // none, inline, bottom
//   ..chosen, // other options: theme, logo-with-text
// ) = { body => {

//   if lang != "en" and lang != "de" {
//     panic("Unknown language: " + lang)
//   }

//   /// set options
//   options.update(o => {
//     o.variant = variant
//     o.theme = color-theme.blue
//     o.lang = lang
//     o.spell = i18n.at(lang)
//     o.logo-with-text = chosen.named().at("logo-with-text", default: false)
//     o.show-solution = chosen.named().at("solution", default: none)
//     return o
//   })
//   let theme = color-theme.blue
//   let spell = i18n.at(lang)

//   set text(
//     lang: lang,
//     font: font,
//     spacing: .5em,
//     size: size,
//   )
//   set par(leading: 0.55em, spacing: 0.55em, justify: true)
//   set page(
//     paper: "a4",
//     margin: (
//       left: 2cm,
//       right: 2cm,
//       top: 1.9cm,
//       bottom: 2.5cm,
//     ),
//     columns: if variant == "report" { 2 } else { 1 },
//     header: header.at(variant)(course, title),
//     footer: footer.at(variant)(course, title)
//   )

//   show raw: set text(font: "CMU Typewriter Text")

//   show figure.where(kind: table): set figure.caption(position: top)
//   show figure.where(kind: table): set figure(supplement: spell.tab, numbering: "1")
//   show figure.where(kind: image): set figure(supplement: spell.fig, numbering: "1")
//   show figure.caption: set align(start)
//   show figure.caption.where(kind: table): set align(center)

//   set figure.caption(separator: [ #sym.minus ])
//   show figure: fig => {
//     let prefix = (
//       if fig.kind == table [#spell.tab]
//       else if fig.kind == image [#spell.fig]
//       else [#fig.supplement]
//     )
//     let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))
//     show figure.caption: it => [
//       #text(weight: "bold")[
//         #prefix~#numbers
//       ]
//       #it.separator#it.body
//     ]
//     show figure.caption.where(kind: table): smallcaps
//     fig
//   }

//   show ref: it => {
//     let el = it.element
//     if el != none and el.func() == metadata and el == enum-label-mark {
//       let supp = it.supplement
//       if supp == auto {
//         supp = spell.item
//       }
//       // get the counter value in the correct format according to location
//       let loc = el.location()
//       let num = enum-numbering-state.at(loc)
//       if std.type(enum-numbering-state.at(loc)) != str {
//         num = enum-numbering-state.at(loc).with(loc:loc)
//       }
//       let ref-counter = numbering(num, ..enum-counter.at(loc))
//       if is-empty(supp) {
//         link(el.location(), ref-counter)
//       }
//       else {
//         link(el.location(), box([#supp~#ref-counter]))
//       }
//     } else {
//       it
//     }
//   }

//   show enum: it => {
//     if it.start != 0 { return it }
//     let args = it.fields()
//     let items = args.remove("children")
//     context enum(..args, start: item-cnt.get().first() + 1, ..items)
//     item-cnt.update(i => i + it.children.len())
//   }

//   set heading(numbering: if variant == "report" {none} else {"1.1"})
//   show heading.where(level: 1): it => {
//     // item-cnt.update(0)
//     if variant == "report" { return it }

//     set block(
//       width: 100%,
//       fill: theme.primary.lighten(80%),
//       inset: 4pt,
//     )
//     if it.numbering == none [
//       #block(it.body)
//     ] else [
//       #block(counter(heading).display(it.numbering)  + h(1em) + it.body)
//     ]
//   }
//   show heading.where(level: 2): it => {
//     if variant == "report" {
//       set text(weight: "light", size: size)
//       emph(it)
//     } else { it }
//   }
//   show heading.where(label: <bmim:nonumber>): set heading(numbering: none, outlined: false)

//   // ### Outline
//   set outline(depth: 2)
//   set outline.entry(fill: repeat[.~])

//   show outline.entry.where(level: 1): it => {
//     if it.element.func() != heading {
//       return it
//     }

//     set block(above:1em)
//     strong(link(
//       it.element.location(),
//       it.indented(it.prefix(), {it.body(); h(1fr); it.page()}),
//     ))
//   }

//   // ### Title
//   if variant not in  ("workbook", "slides") {
//     titleblock.at(variant)(course, title, authors, date)
//   }
//   // ###
//   body

//   // ### Separate Solutions for Exam
//   if variant == "exam" { pagebreak(); task-solutions }

// }}
