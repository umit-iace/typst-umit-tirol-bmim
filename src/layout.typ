#import "task.typ"
#import "utils.typ": *
#import "options.typ": *

#let heading-colored(it) = context {
    let opts = options.final()
    set block(
        width: 100%,
        fill: opts.theme.lolight,
        inset: 4pt,
    )
    place(hide(it))
    if it.numbering == none [
        #block(it.body)
    ] else [
        #block(counter(heading).display(it.numbering) + h(1em) + it.body)
    ]
}

#let underline-space(fraction) = box(height: -1pt, line(length: fraction))

#let banner(..args) = {
    let opts = options.final()
    box(
        width: 100%,
        height: 1.5em,
        fill: opts.theme.highlight,
        if args.pos().len() != 0 {
            set align(horizon)
            // set text(1.2em, white)
            set text(opts.theme.neutral-lightest)
            // show: strong
            pad(x: 1.5em, ..args.pos())
        },
    )
}

#let header-colored(title: none) = context {
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
                    image("./../assets/iace.svg", height: 2.65em),
                ),
            ),
            grid.cell(
                banner(title),
            ),
            align(top, pad(
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
                    },
                ),
            )),
            banner(),
        ),
    )
}

#let header-poster(title: none, authors: none) = context {
    let opts = options.final()
    // undo page margin
    pad(
        top: -4em,
        left: -1.5em,
        right: -1.5em,
        box(
            width: 100%,
            height: 100%,
            fill: opts.theme.highlight,
            (titleblock.poster)(title, authors),
        ),
    )
    // pad(
    //   bottom: 0.25em,
    //   left: -5%,
    //   right: -5%,
    //   grid(
    //     columns: (5%, auto, 1fr, auto, 5%),
    // banner(),
    // grid.cell(
    //   pad(
    //     left: -0.6em,
    //     right: -0.2em,
    //     bottom: -0.43em,
    //     image("./../assets/iace.svg", height: 2.65em)
    //   )
    // ),
    // grid.cell(
    //   banner(title)
    // ),
    // align(top,
    //   pad(
    //     left: 0.2em,
    //     right: 0.2em,
    //     top: 0.72em,
    //     bottom: -1em,
    //     image(
    //       width: 9.55em,
    //       if opts.logo-with-text {
    //         if opts.lang == "en" {
    //           "./../assets/logo_umit_eng.svg"
    //         } else {
    //           "./../assets/logo_umit_de.svg"
    //         }
    //       } else {
    //         "./../assets/logo_umit_wo.svg"
    //       }
    //     )
    //   )
    // ),
    // banner(),
    // )
    // )
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
        head
        h(1fr)
        pagenum
    } else {
        pagenum
        h(1fr)
        head
    }
    line(length: 100%, stroke: 0.5pt)
}

#let header = (
    lab: header-colored(),
    exam: header-colored(),
    exercise: header-colored(),
    report: header-colored(),
    // poster: (title, authors) => header-poster(title, authors),
    lecture: header-colored(),
    slides: header-colored(title: context if opts.variant == "slides" {
        let list = query(heading.where(level: 1).before(here()))
        if list.len() != 0 {
            list.last().body
        }
    }),
    workbook: context {
        if page-is-chap-start() {
            none
        } else {
            header-colored()
        }
    },
)

#let footer = (
    exam: (course, title) => context {
        let opts = options.final()
        let course = if type(course) == array { course.at(1) } else { course }
        set text(size: 11pt)
        line(length: 100%, stroke: 0.5pt)
        let foot = [
            #opts.spell.exam - #course
            #if opts.show-solution != none [
                #set text(color.red, stroke: 0.5pt + color.red)
                #opts.spell.with #opts.spell.sol
            ]
        ]
        let pagenum = counter(page).display("1/1", both: true)
        if calc.odd(here().page()) and here().page() != 1 [
            #foot
            #h(1fr)
            Matrikelnr: #underline-space(25%)
            #h(1fr)
            #pagenum
        ] else if here().page() == 1 [
            #foot
            #h(1fr)
            #pagenum
        ] else [
            #pagenum
            #h(1fr)
            #foot
        ]
    },
    exercise: (course, title) => context {
        let opts = options.final()
        let course = if type(course) == array { course.at(1) } else { course }
        let title = if type(title) == array { title.join([ \- ]) } else {
            title
        }
        set text(size: 0.8em)
        line(length: 100%, stroke: 0.5pt)
        let foot = [
            #course - #title
            #if opts.show-solution != none [
                #set text(color.red, stroke: 0.5pt + color.red)
                #opts.spell.with #opts.spell.sol
            ]
        ]
        let pagenum = counter(page).display("1")
        if calc.odd(here().page()) {
            foot
            h(1fr)
            pagenum
        } else {
            pagenum
            h(1fr)
            foot
        }
    },
    lab: (course, title) => context {
        let opts = options.final()
        let course = if type(course) == array { course.at(1) } else { course }
        let title = if type(title) == array { title.join([ \- ]) } else {
            title
        }
        set text(size: 0.8em)
        line(length: 100%, stroke: 0.5pt)
        let foot = [
            #opts.spell.lab - #course - #title
            #if opts.show-solution != none [
                #set text(color.red, stroke: 0.5pt + color.red)
                #opts.spell.with #opts.spell.sol
            ]
        ]
        let pagenum = counter(page).display("1")
        if calc.odd(here().page()) {
            foot
            h(1fr)
            pagenum
        } else {
            pagenum
            h(1fr)
            foot
        }
    },
    lecture: () => context {},
    poster: (event, date, location, contact, ..args) => context {
        //     set text(font: "CMU Typewriter Text")
        //     let opts = options.final()
        //     // let ext = 5%
        //     let ext = 0.4em + 1pt
        //     pad(
        //         left: -ext,
        //         right: -ext,
        //         grid(
        //             columns: (ext, 2fr, 1fr, ext),
        //             align: (auto, left, right, auto),
        //             column-gutter: -1pt,
        //             banner(),
        //             banner([#event, #print-date(date), #location]),
        //             banner([#contact]),
        //             banner(),
        //         ),
        //     )
    },
    report: (course, title) => context {
        align(
            if calc.odd(here().page()) { right } else { left },
            counter(page).display("1"),
        )
    },
    slides: () => context {},
    workbook: course => context {
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
        ] else if here().page() == 1 [
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

#let titleblock = (
    exam: (course, title, authors, date, total-time, show-hints) => context {
        let opts = options.final()
        let course = if type(course) == array { course.at(0) } else { course }

        [
            #set align(center)

            *#title - #course*
        ]
        v(1em)
        grid(
            columns: (2fr, 1fr),
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
        )
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
            if show-hints {
                {
                    set list(spacing: 1.3em)
                    set text(size: 10pt)
                    [
                        *Hinweise*
                        #v(0.75em)
                        #pad(left: 1.4em)[
                            - Die Prüfung umfasst #context task.total-count()
                                Aufgaben, die Bearbeitungszeit beträgt
                                #total-time.
                            - Es können insgesamt #context task.total-points()
                                Punkte erreicht werden.
                            - Zugelassene Hilfsmittel:
                                - *ein handschriftlich* beschriebener A4 Zettel;
                                    *Muss* am Ende der Klausur abgegeben werden.
                                - *keine* weiteren Unterlagen
                                - *keine* elektronischen Geräte
                            - Bitte schreiben Sie *leserlich* und geben Sie den
                                *Lösungsweg* vollständig an.
                            - Schreiben Sie *nicht* mit Bleistift und *nicht*
                                mit Rotstift.
                        ]
                    ]
                }
            },
        )
        v(1.25em)
        table(
            inset: 0.5em,
            gutter: 0.5em,
            stroke: 0.5pt,
            align: left,
            ..tableData.filter(x => x != none)
        )
    },
    exercise: (course, title, authors, date) => context {
        let opts = options.final()
        let course = if type(course) == array { course.at(0) } else { course }

        [
            #set align(center)

            *#title - #course*
        ]
        v(1em)
        grid(
            columns: (2fr, 1fr),
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
        )
    },
    lab: (course, title, authors, date) => context {
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
                    #sym.hyph \
                    #course \
                    #line(length: 95%)
                    #if type(title) == array {
                        title.at(0)
                        linebreak()
                        title.at(1)
                    } else {
                        title
                    }
                ],
            ),
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
                #curDate.day(). #translatedMonth(curDate, opts.lang)
                #curDate.year()
            ],
        )
    },
    lecture: () => context {},
    poster: (title, authors) => context {
        place(top + center, float: true, scope: "parent", [
            #text(1.4em, strong(title))\
            #authors.join([\ ])
        ])
    },
    report: (course, title, authors, date) => context place(
        top,
        float: true,
        scope: "parent",
        block(inset: (top: 2em, bottom: 1em), {
            set par(spacing: 1em)
            let opts = options.final()
            let title = text(opts.theme.highlight, 2em, strong(title))
            let w = measure(title).width
            title
            line(length: w + 0.5em, stroke: 1pt)
            authors.join(", ")
            par[#opts.spell.date: #print-date(date)]
            line(length: w + 0.5em, stroke: 3pt)
        }),
    ),
    slides: (course, title, authors, date) => context {},
    workbook: (course, authors, date) => context {
        let opts = options.final()
        let course = if type(course) == array { course.at(0) } else { course }
        set align(center + horizon)
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
                authors.map(smallcaps).join([, ])
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
                            image("./../assets/iace.svg", height: 2.65em),
                        ),
                    ),
                )
            ]
            #print-date(date)
        ]
        pagebreak(to: "odd")
    },
)

#let poster-box(heading, content, height: none) = context {
    let opts = options.final()
    set align(left)
    [
        #std.heading(heading)
        #block(
            height: .5em,
            width: 7em,
            fill: opts.theme.lowlight,
            above: .75em,
            below: 1.25em,
        )
        #block(
            width: 100%,
            height: if height == none { auto } else { height },
            content,
        )
    ]
}

#let poster-vsep = context {
    let opts = options.final()
    set align(center)
    block(
        height: .25em,
        width: 61.8%,
        fill: opts.theme.neutral-lightest,
        above: 1em,
    )
}

#let poster-hsep = context {
    let opts = options.final()
    align(horizon)[
        #block(
            width: .25em,
            height: 61.8%,
            fill: opts.theme.neutral-lightest,
        )
    ]
}

#let solution-box(sol) = {
    block(
        // stroke:0.5pt,
        width: 100%,
        fill: color.red.lighten(0%),
        inset: 2pt,
        box(
            stroke: 0.5pt,
            width: 100%,
            fill: white,
            inset: 0.3em,
            sol,
        ),
    )
}
