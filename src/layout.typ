#import "task.typ"
#import "utils.typ": *
#import "options.typ": *
#import "slides.typ": *


#let heading-colored(it) = context {
  let opts = options.final()
  set block(
    width: 100%,
    fill: opts.theme.primary.lighten(90%),
    inset: 4pt,
  )
  place(hide(it))
  if it.numbering == none [
    #block(it.body)
  ] else [
    #block(counter(heading).display(it.numbering)  + h(1em) + it.body)
  ]
}

#let heading-colored2(it) = context {
  let opts = options.final()
  set text(weight: "semibold")
  if it.numbering == none [
    #block(
      width: if opts.task-show-points {100%} else {33%},
      inset: (bottom: 5pt),
      stroke: (bottom: 0.1em + opts.theme.primary),
      [#it.body]
    )
  ] else [
    #block(
      inset: (bottom: 5pt),
      stroke: (bottom: 0.1em + opts.theme.primary),
      [#counter(heading).display(it.numbering) #it.body]
    )
  ]
}

#let underline-space(fraction) = box(height: -1pt, line(length: fraction))

#let banner(..args) = {
  let opts = options.final()
  let height = if args.named().at("slide", default: false) {0.5em} else {1.5em}
  let size = args.named().at("size", default: 1em)
  let all-sections = query(outline.entry.where(level: 1))
  let current-section = utils.current-heading(level: 1)
  show text: set text(size: size, fill: opts.theme.background)
  let showAni = args.named().at("progressAnimation", default: false)

  grid(
    columns: if args.named().at("slide", default: false) and showAni {(auto, 1fr)} else {(auto)},
    gutter: 1pt,
    grid.cell(
      box(
        width: if args.named().at("slide", default: false) and showAni {80%} else {100%},
        height: height,
        if args.pos().len() != 0 {
          set align(horizon+center)
          show text: set text(size: size, fill: opts.theme.background)
          pad(..args.pos())
        }
      )
    ),
    if args.named().at("slide", default: false) and showAni {
      grid.cell(
        box(
          width: 100%,
          height: height,
          align(horizon+center)[
            #stack(
              dir: ltr,
              spacing: 10pt,
              ..all-sections.enumerate().map(((idx, sec)) => {
                let is-current = sec.element.location() == current-section.location()

                let dot = if is-current {
                  circle(radius: 3.5pt, stroke: 1pt + gray.lighten(20%), fill: gray.lighten(20%))
                } else {
                  circle(radius: 3.5pt, stroke: 1pt + gray.lighten(20%), fill: none)
                }
                dot
              })
            )
          ]
        )
      )
    }
  )
}

#let header-colored(title:none) = context {
  let opts = options.final()
  pad(
    top: page.margin.top * 0.3,
    left: -page.margin.left * 0.4,
    rect(
      fill: opts.theme.primary,
      width: 100% + page.margin.left * 0.4,
      height: 80%,
    )
  )
  pad(
    top: page.margin.top * 0.3,
    left: -page.margin.left * 0.4,
    grid(
      columns: (auto, 1fr, auto),
      grid.cell(
        pad(
          left: page.margin.left * 0.4,
          bottom: page.margin.top * 0.12,
          image(
            "./../assets/logo_iace_white.svg", height: page.margin.top * 0.254
          )
        )
      ),
      grid.cell(
        banner(title)
      ),
      grid.cell(
        pad(
          bottom: page.margin.top * 0.135,
          image(
            "./../assets/logo_umit_white_wo.svg", height: page.margin.top * 0.17
          )
        )
      ),
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
  line(length: 100%, stroke: 0.25mm)
}

#let header = (
  exam: header-colored(),
  exercise: header-colored(),
  report: header-colored(),
  lecture: header-colored(),
  letter: () => context {
    image(
      "./../assets/logo_umit_blue_gr.png",
      width: 33%
    )
  },
  poster: header-colored(),
  article: header-colored(),
  slides: (heading: none, progressAnimation: none) => context {
    let opts = options.final()
    let showAni = type(progressAnimation) == dictionary and progressAnimation.at("section", default: false)
    let logo-left = if type(opts.logo) == dictionary {
      opts.logo.at("left", default: auto)
    } else {
      opts.logo
    }
    let logo-right = if type(opts.logo) == dictionary {
      opts.logo.at("right", default: auto)
    } else {
      opts.logo
    }
    set text(weight: "bold")
    rect(
      fill: opts.theme.primary,
      width: 100%,
      height: 100%,
    )
    pad(
      top: -page.margin.top * 1.42,
      grid(
        columns: (auto, 1fr, auto),
        if logo-left == auto {
          pad(
            top: -6.5pt,
            left: page.margin.left - 11%,
            image("./../assets/logo_iace_white.svg", height: 20.8pt)
          )
        } else {
          logo-left
        },
        pad( x: -1pt,
          banner(slide: true, size: 17.6pt, progressAnimation: showAni, move(dy: 0.5pt, heading))
        ),
        if logo-right == auto {
          pad(
            top: -2.2pt,
            right: page.margin.right,
            image("./../assets/logo_umit_white_wo.svg", height: 17.2pt)
          )
        } else {
          logo-right
        },
      )
    )
  },
  workbook: context {
    if page-is-chap-start() {
      none
    } else {
      header-colored()
    }
  },
)

#let bmim-footer(course, title) = context {
    let opts = options.final()
    let course = if type(course) == array { course.at(1) } else { course }
    let title = if type(title) == array { title.join([ \- ]) } else { title }
    set text(size: 0.8em)
    line(length: 100%, stroke: 0.5pt)
    let foot = [
      #course - #title
      #if opts.show-solution != none [
        #set text(color.red)
        *#opts.spell.with #opts.spell.sol*
      ]
    ]
    let pagenum = counter(page).display("1")
    if calc.odd(here().page()) {
      foot; h(1fr); pagenum
    } else {
      pagenum; h(1fr); foot
    }
}

#let footer = (
  exam: (course, title) => context {
    let opts = options.final()
    let course = if type(course) == array { course.at(1) } else { course }
    set text(size: 11pt)
    line(length: 100%, stroke: 0.25mm)
    let foot = [
      #opts.spell.exam - #course
      #if opts.show-solution != none [
        #set text(color.red)
        *#opts.spell.with #opts.spell.sol*
      ]
    ]
    let pagenum = counter(page).display("1/1", both: true)
    if calc.odd(here().page()) and here().page() != 1 [
      #foot
      #h(1fr)
      Matrikelnr: #underline-space(25%)
      #h(1fr)
      #pagenum
    ]
    else if here().page() == 1 [
      #foot
      #h(1fr)
      #pagenum
    ] else [
      #pagenum
      #h(1fr)
      #foot
    ]
  },
  exercise: (course, title) => bmim-footer(course, title),
  report: (course, title) => bmim-footer(course, title),
  lecture: (course) => context{
    let opts = options.final()
    let course = if type(course) == array { course.at(1) } else { course }
    set text(size: 0.8em)
    line(length: 100%, stroke: 0.5pt)
    let foot = [
      #course
      #if opts.show-solution != none [
        #set text(color.red)
        *#opts.spell.with #opts.spell.sol*
      ]
    ]
    let pagenum = counter(page).display("1")
    if calc.odd(here().page()) {
      foot; h(1fr); pagenum
    } else {
      pagenum; h(1fr); foot
    }
  },
  letter: () => context {
    image(
      "./../assets/footer_umit_gr.png",
      width: 100%
    )
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
  article: (course, title) => context {
    align(
      if calc.odd(here().page()) { right } else {left},
      counter(page).display("1")
    )
  },
  slides: (author:none, title:none, date:none, pagenum:none, progressAnimation:none) => context {
    let opts = options.final()
    let showAni = type(progressAnimation) == dictionary and progressAnimation.at("slides", default: false)
    block(
      [
        #if showAni {
          block(
            inset: (bottom: -page.height * 5.7%),
            components.progress-bar(height: page.height * 3.3%, opts.theme.highlight, opts.theme.primary)
          )
        }
        #box(
          stroke: (
            top: opts.theme.secondary + 0pt,
          ),
          fill: if showAni {none} else {opts.theme.primary},
          inset: (left: page.margin.left, right: page.margin.right, top: -page.height * 0.525%, bottom: page.height * 0.9%),
          grid(
            columns: (auto, 70%, 1fr, 5%),
            gutter: 2%,
            align: (left, left, center, right),
            rows: page.height * 2.8%,
            text(white)[#author],
            text(white)[#title],
            if opts.lang == "de" {
              text(white)[#date.day(). #translatedMonth(date, opts.lang) #date.year()]
            } else {
              text(white)[#translatedMonth(date, opts.lang) #date.day(), #date.year()]
            },
            text(white)[#pagenum],
          ),
        )
      ]
    )
  },
  workbook: (course) => context {
    let opts = options.final()
    let course = if type(course) == array { course.at(1) } else { course }
    set text(size: 11pt)
    line(length: 100%, stroke: 0.5pt)
    let foot = [
      #course - Übungsaufgaben
    ]
    let pagenum = counter(page).display("1")
    if calc.odd(here().page()) and here().page() != 1 [
      #foot
      #h(1fr)
      #pagenum
    ]
    else if here().page() == 1 [
      #foot
      #h(1fr)
      #pagenum
    ] else [
      #pagenum
      #h(1fr)
      #foot
    ]
  },
)

#let finalblock = (
  lecture: () => context {
  },
  letter: (sender-name, sender-pos, signature) => context {
    let opts = options.final()

    v(2em)
    opts.spell.regards
    if signature != none {
      v(0.25em)
      signature
      v(0.25em)
    } else {
      v(4em)
    }
    sender-name
    linebreak()
    sender-pos
  },
)

#let bmim-title(args) = {
    let opts = options.final()
    let course = if type(args.course) == array { args.course.at(0) } else { args.course }

    align(center,
      box(
        width: 77%,
        stroke: (bottom: 1pt),
        inset: (bottom: 7pt),
        [
          #text(size: 2em)[#args.title]
          #v(-1.5em)
          #text(size: 1.2em)[#course]
        ])
    )
    grid(
      columns: (2fr, 1fr),
      gutter: 0.5em,
      align: (right, left),
      text[
        #if opts.show-solution != none {
          set text(color.red)
          strong[
            #opts.spell.with #opts.spell.sol,
          ]
        }
        #if args.date != none [
          #opts.spell.on 
          #args.date.day(). #translatedMonth(args.date, opts.lang)
          #args.date.year(), 
        ]
        #opts.spell.ho:
      ],
      grid(
        row-gutter: 0.5em,
        ..args.authors.map(author => text(author)),
      ),
    )
}

#let titleblock = (
  exam:     (args) => context {
    let opts = options.final()
    bmim-title(args)
    v(1.25em)
    grid(
      columns: (1fr, 1fr),
      gutter: 0.5em,
      align: (right, left),
      [
        Name: #underline-space(73%) #h(2em)
      ],
      [
        Matrikelnummer: #underline-space(50%)
      ],
    )
    v(1.25em)

    let tableData = (
      {
        strong(opts.spell.eval)
        task.points-table
      },
      if args.show-hints {
        {
          set list(spacing: 1.3em)
          [
            *Hinweise*
            #set text(size: 0.9em)
            #pad(left: 1.4em)[
              - Die Prüfung umfasst *#context task.total-count()* Aufgaben, die Bearbeitungszeit beträgt *#args.total-time*.
              - Es können insgesamt *#context task.total-points()* Punkte erreicht werden.
              - Zugelassene Hilfsmittel:
                - *Ein handschriftlich* beschriebener A4 Zettel, am Ende der Klausur *abzugeben*.
              - *Nicht zugelassene* Hilfsmittel:
                - Jegliche Unterlagen
                - Elektronische Geräte
              - Schreiben Sie *leserlich* und geben Sie den *Lösungsweg* vollständig an.
              - Schreiben Sie *nicht* mit Bleistift und *nicht* mit Rotstift.
            ]
          ]
        }
      }
    )
    v(1.25em)
    table(
      inset: 0.5em,
      gutter: 0.5em,
      stroke: 0.1em,
      align:left,
      ..tableData.filter(x => x != none)
    )
  },
  exercise: (args) => bmim-title(args),
  report: (args) => context {
    let margs = args
    margs.date = none
    bmim-title(margs)
    let opts = options.final()
    set align(center)
    grid(
      columns: (2fr, 1fr),
      gutter: 0.5em,
      align: (right, left),
      [
        #opts.spell.lc:
      ],
      [
        #args.date.day(). #translatedMonth(args.date, opts.lang) #args.date.year()
      ],
    )
  },
  lecture: () => context {
  },
  letter: (
    recipient-pro,
    recipient-name,
    recipient-address,
    recipient-institution,
    sender-department,
    sender-institute,
    sender-pos,
    sender-name,
    sender-tel,
    sender-fax,
    sender-email,
    location,
    date,
    subject
  ) => context {
    let headText(body) = {
      set text(gray, size: 8pt)
      if body != none {
        lower(body)
        linebreak()
      }
    }
    // left block
    place(top + left, [
      #if sender-department != none {
        headText(sender-department)
      }
      #headText(sender-institute)
      #text(size: 10pt)[
        #if recipient-institution != none [
          #recipient-institution \
        ]
        #if recipient-pro != none [
          #recipient-pro
        ]
        #if recipient-name != none [
          #recipient-name \
        ]
        #recipient-address
      ]
    ])
    // right block
    place(top + right, [
      #align(left)[
        #if sender-department != none {
          headText(sym.zwj)
        }
        #headText(sender-pos)
        #text(size: 8pt)[
          #sender-name \
          T #sender-tel \
          #if sender-fax != none {
            [F #sender-fax #linebreak()]
          }
          E #sender-email
        ]
      ]
    ])
    // date block
    v(10.5em)
    align(right)[
      #location, #print-date(date)
    ]
    // subject line
    // (should appear above the first fold)
    v(1.5em)
    if subject != none {
      text(weight: "bold")[#subject]
      v(2em)
    }
  },
  poster:   (title, authors) => context {
    place(top+center, float: true, scope: "parent",[
      #text(1.4em, strong(title))\
      #authors.join([\ ])
    ])
  },
  article:   (args) => context place(
    top, float: true, scope: "parent",
    block(inset: (top: 2em, bottom: 1em), {
      set par(spacing: 1em)
      let opts = options.final()
      let title = text(opts.theme.highlight, 2em, strong(args.title))
      let w = measure(title).width
      title
      line(length: w+0.5em, stroke: 1pt)
      args.authors.join(", ")
      par[#opts.spell.date: #print-date(args.date)]
      line(length: w+0.5em, stroke: 3pt)

    })
  ),
  slides: () => context {},
  workbook: (args) => context {
    let opts = options.final()
    let course = if type(args.course) == array { args.course.at(0) } else { args.course }
    set align(center+horizon)
    set par(spacing: 3em)

    [
      #smallcaps[
        #set text(1.3em)
        Übungsaufgaben zur Lehrveranstaltung
      ]

      #{
        set text(1.5em)
        strong(course)
      }

      #{
        set text(1.3em)
        args.authors.map(smallcaps).join([, ])
      }
      #par[]
      #par[]
      #[
        #set text(1.1em)
        Institut für Automatisierungs- und Regelungstechnik

        #grid(
          columns: (auto, auto),
          grid.cell(
            pad(
              left: -0.6em,
              right: -0.2em,
              image("./../assets/logo_iace_black.svg", height: 2.65em)
            )
          )
        )
      ]
      #print-date(args.date)
    ]
    pagebreak(to: "odd")
  },
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

#let solution-box(sol) = {
  block(
    // stroke:0.5pt,
    width: 100%,
    fill: color.red.lighten(0%),
    inset: 2pt,
    box(
      stroke:0.5pt,
      width: 100%,
      fill: white,
      inset: 0.3em,
      sol,
    ),
  )
}

