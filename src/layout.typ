#import "task.typ": t-count, t-points, task-show-table
#import "utils.typ": *
#import "options.typ": *


#let underline-space(fraction) = box(height: -1pt, line(length: fraction))

#let banner(..args) = {
  let opts = options.final()
  box(
    width: 100%, height: 1.5em,
    fill: opts.theme.highlight,
    if args.pos().len() != 0 {
      set align(horizon)
      // set text(1.2em, white)
      set text(opts.theme.neutral-lightest)
      // show: strong
      pad(x:1.5em, ..args.pos())
    }
  )
}
#let header-colored(title:none) = context {
  let opts = options.final()
  pad(
    bottom: 0.25em,
    left: -5%,
    right: -5%,
    grid(
      columns: (5%, auto, 1fr, auto, 5%),
      banner(),
      grid.cell(
        pad(
          left: -0.6em,
          right: -0.2em,
          bottom: -0.43em,
          image("./../assets/iace.svg", height: 2.65em)
        )
      ),
      grid.cell(
        banner(title)
      ),
      align(top,
        pad(
          left: 0.2em,
          right: 0.2em,
          top: 0.72em,
          bottom: -1em,
          image(
            width: 9.55em,
            if opts.logo-with-text {
              if opts.lang == "en" {
                "./../assets/logo_umit_eng.svg"
              } else {
                "./../assets/logo_umit_de.svg"
              }
            } else {
              "./../assets/logo_umit_wo.svg"
            }
          )
        )
      ),
      banner(),
    )
  )
}

#let header-plain(course, title) = context {
  set text(size: 0.8em)
  let opts = options.final()
  let course = if type(course) == array { course.at(1) } else { course }
  let this-page = here().page()
  let head = [
    #title -- #course
  ]
  let pagenum = [
    #opts.spell.page #this-page #opts.spell.of
    #counter(page).final().first()
  ]
  if calc.odd(this-page) {
    head; h(1fr); pagenum
  } else {
    pagenum; h(1fr); head
  }
  line(length: 100%, stroke: 0.5pt)
}

#let header = (
  lab: header-colored(),
  exam: header-plain,
  report: header-colored(),
  poster: header-colored(),
  slides: header-colored(title:
        context if opts.variant == "slides" {
          let list = query(heading.where(level:1).before(here()))
          if list.len() != 0 {
            list.last().body
          }
        }),
)

#let footer = (
  lab: (course, title) => context {
    let opts = options.final()
    let course = if type(course) == array { course.at(1) } else { course }
    let title = if type(title) == array { title.join([ \- ]) } else { title }
    set text(size: 0.8em)
    line(length: 100%, stroke: 0.5pt)
    let foot = [
      #opts.spell.lab #course - #title
      #if opts.show-solution != none [
        #set text(color.red, stroke: 0.5pt+color.red)
        #opts.spell.with #opts.spell.sol
      ]
    ]
    let pagenum = counter(page).display("1")
    if calc.odd(here().page()) {
      foot; h(1fr); pagenum
    } else {
      pagenum; h(1fr); foot
    }
  },
  exam: (course, title) => context {
    let opts = options.final()
    let course = if type(course) == array { course.at(1) } else { course }
    set text(size: 11pt)
    line(length: 100%, stroke: 0.5pt)
    let foot = [
      #opts.spell.exam - #course
      #if opts.show-solution != none [
        #set text(color.red, stroke: 0.5pt+color.red)
        #opts.spell.with #opts.spell.sol
      ]
    ]
    let pagenum = counter(page).display("1/1")
    if calc.odd(here().page()) and here().page() != 1 [
      #foot
      #h(1fr)
      Matrikelnr: #underline-space(25%)
      #h(1fr)
      #pagenum
    ] else [
      #pagenum
      #h(1fr)
      #foot
    ]
  },
  poster: (event,date,location,contact, ..args) => context {
    set text(font: "CMU Typewriter Text")
    let opts = options.final()
    // let ext = 5%
    let ext = 0.4em+1pt
    pad(
      left: -ext,
      right: -ext,
      grid(
        columns: (ext, 2fr, 1fr, ext),
        align: (auto, left, right, auto),
        column-gutter: -1pt,
        banner(),
        banner([#event, #print-date(date), #location]),
        banner([#contact]),
        banner(),
      )
    )
  },
  report: (course, title) => context {
    align(
      if calc.odd(here().page()) { right } else {left},
      counter(page).display("1")
    )
  }
)

#let titleblock = (
  exam:     (course, title, authors, date, total-time) => context {
    let opts = options.final()
    let course = if type(course) == array { course.at(0) } else { course }

    [
      #box(image("./../assets/iace.svg", height: 2.02em))
      #h(1fr)
      #box(image(height: 2.02em,
              if opts.lang == "en" {
                "./../assets/logo_umit_eng.svg"
              } else {
                "./../assets/logo_umit_de.svg"
              }
            ))
      #set align(center)

      *#title - #course*
    ]
    v(1em)
    grid(
      columns: (1.25fr, 1fr),
      gutter: 0.5em,
      align: (right, left),
      strong[
        #opts.spell.on #date.day(). #translatedMonth(date, opts.lang)
        #date.year(), #opts.spell.ho:
      ],
      grid(
        row-gutter: 0.5em,
        ..authors.map(author => strong(author)),
      ),
      grid.cell( colspan: 2, v(0.75em),),
      [
        Name: #underline-space(73%) #h(2em)
      ],
      [
        Matrikelnummer: #underline-space(50%)
      ],
    )
    v(1.25em)
    table(
      inset: 0.5em,
      gutter: 0.5em,
      stroke: 0.5pt,
      align:left,
      {
        strong(opts.spell.eval)
        task-show-table
      },
      {
        set list(spacing: 1.3em)
        set text(size: 10pt)
        [
          *Hinweise*
          #v(0.75em)
          #pad(left: 1.4em)[
            - Die Prüfung umfasst #t-count.final().first() Aufgaben, die
              Bearbeitungszeit beträgt #total-time.
            - Es können insgesamt #t-points.final().sum() Punkte erreicht werden.
            - Zugelassene Hilfsmittel:
              - *ein handschriftlich* beschriebener A4 Zettel; *Muss* am Ende der Klausur abgegeben werden.
              - *keine* weiteren Unterlagen
              - *keine* elektronischen Geräte
            - Bitte schreiben Sie *leserlich* und geben Sie den *Lösungsweg* vollständig an.
            - Schreiben Sie *nicht* mit Bleistift und *nicht* mit Rotstift.
          ]
        ]
      }
    )
  },
  exercise: (course, title, authors, date) => context { },
  lab:      (course, title, authors, date) => context {
    let course = if type(course) == array { course.at(0) } else { course }
    let opts = options.final()
    set align(center)
    rect(
      width: 100%,
      inset: (top: 0.2em, bottom: 0.2em, left: 0.2em, right: 0.2em),
      stroke: 1pt,
      rect(
        width: 100%,
        inset: (top: 1em, bottom: 1em),
        stroke: (paint: black.lighten(20%), thickness: 1.3pt),
        strong[
          #opts.spell.lab \
          #course \
          #if type(title) == array {
            sym.hyph; linebreak()
            title.at(0)
          }
          #line(length: 95%)
          #if type(title) == array {
            title.at(1)
          } else {
            title
          }
        ]
      )
    )
    grid(
      columns: 2,
      gutter: 0.75em,
      align: (right, left),
      [
        #if opts.show-solution != none {
          set text(color.red)
          strong[
            #opts.spell.with #opts.spell.sol,
          ]
        }
        #opts.spell.ho:
      ],
      grid(
        row-gutter: 0.5em,
        ..authors.map(author => text(author)),
      ),
      [
        #opts.spell.lc:
      ],
      [
        #let curDate = datetime.today()
        #curDate.day(). #translatedMonth(curDate, opts.lang) #curDate.year()
      ],
    )
  },
  report:   (course, title, authors, date) => context place(
    top, float: true, scope: "parent",
    block(inset: (top: 2em, bottom: 1em), {
      set par(spacing: 1em)
      let opts = options.final()
      let title = text(opts.theme.highlight, 2em, strong(title))
      let w = measure(title).width
      title
      line(length: w+0.5em, stroke: 1pt)
      authors.join(", ")
      par[#opts.spell.date: #print-date(date)]
      line(length: w+0.5em, stroke: 3pt)

    })
  ),
  poster:   (title, authors) => context {
    place(top+center, float: true, scope: "parent",[
      #text(1.4em, strong(title))\
      #authors.join([\ ])
    ])
  },
  slides:   (course, title, authors, date) => context { },
)

#let poster-box(heading, content, height:none) = context {
  let opts = options.final()
  show std.heading.where(level:1): it => {
    let opts = options.final()
    set text(fill: opts.theme.neutral-lightest, size: 0.8em)
    set align(center)
    set block(
      width: 100%,
      outset: 0.4em,
      fill: opts.theme.highlight,
      radius: (
        top: 0.4em
      ),
    )
    it
  }
  std.heading(heading)
  block(
    width: 100%,
    height: if height == none { auto } else { height },
    outset: (x:0.4em, y: 0.2em),
    inset: (x: 0.4em, y:0.2em),
    fill: opts.theme.highlight.lighten(90%),
    stroke: opts.theme.highlight + 0.1em,

    content
  )
}
