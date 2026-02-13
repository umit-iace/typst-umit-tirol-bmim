#import "@preview/rustycure:0.2.0": qr-code

#import "utils.typ": *
#import "layout.typ": *
#import "list.typ": *
#import "task.typ"

#let item-cnt = counter("item-counter")

#let bmim-common(body) = context {
    let opts = options.final()
    set text(
        lang: opts.lang,
        font: opts.font,
        spacing: .5em,
        size: opts.size,
    )
    set par(
        leading: 0.55em,
        spacing: 0.55em,
        justify: true,
        justification-limits: (
            tracking: (min: -0.01em, max: 0.02em),
        ),
    )
    set page(
        margin: (
            left: 2cm,
            right: 2cm,
            top: 1.9cm,
            bottom: 2.5cm,
        ),
    )
    show raw: set text(font: "CMU Typewriter Text", size: opts.size)

    set enum(numbering: "a)")

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
            *#cap.supplement~#n*~#sym.minus#cap.body
        ]
        fig
    }

    show ref: enum-show-ref.with(opts: opts)
    show enum: it => {
        if it.start != 0 { return it }
        let args = it.fields()
        let items = args.remove("children")
        context enum(..args, start: item-cnt.get().first() + 1, ..items)
        item-cnt.update(i => i + it.children.len())
    }

    // set heading(numbering: "1.1")
    show heading.where(level: 1): it => {
        item-cnt.update(0)
        it
    }

    show heading.where(label: <bmim:nonumber>): set heading(
        numbering: none,
        outlined: false,
    )

    // ### Outline
    set outline(depth: 2)
    set outline.entry(fill: repeat[.~])

    show outline.entry.where(level: 1): it => {
        if it.element.func() != heading {
            return it
        }

        set block(above: 1em)
        strong(link(
            it.element.location(),
            it.indented(it.prefix(), {
                it.body()
                h(1fr)
                it.page()
            }),
        ))
    }

    body
}

#let exam(
    course: none, // [Course Name] or ([Course Name], [Short Course Name])
    title: none, // str or content
    authors: none, // array of str or content
    date: datetime.today(), // datetime or content
    total-time: none, // str or content
    show-solution: none, // none, "inline", "bottom"
    empty-sheets: auto, // none, auto (= 1 per task), int
    show-hints: true, // false, true
    ..chosen, // other options: theme, logo-with-text, size, etc
) = {
    body => {
        if total-time == none {
            panic("Exam needs total-time option set")
        }
        option-set(
            (task-show: task.style-heading)
                + (show-solution: show-solution)
                + chosen.named(),
        )
        show: bmim-common
        show ref: task.show-ref

        set std.page(
            header: (header.exam),
            footer: (footer.exam)(course, title),
        )

        show heading.where(level: 1): heading-colored

        (titleblock.exam)(course, title, authors, date, total-time, show-hints)
        body

        if show-solution == "bottom" {
            pagebreak(weak: true)
            task.solution-bottom
        }
        context {
            let sheets = if type(empty-sheets) == int {
                empty-sheets
            } else if empty-sheets == auto and show-solution == none {
                task.total-count()
            } else {
                0
            }
            if sheets != 0 {
                pagebreak(weak: true, to: "odd")
                if calc.odd(here().page()) {
                    pagebreak(to: "even")
                }
                pagebreak(to: "even") * sheets
            }
        }
    }
}

#let exercise(
    course: none, // [Course Name] or ([Course Name], [Short Course Name])
    title: none, // str or content
    authors: none, // array of str or content
    date: datetime.today(), // datetime or content
    show-solution: none, // none, "inline", "bottom"
    task-show-points: false,
    ..chosen,
) = {
    body => {
        option-set(
            (task-show: task.style-heading)
                + (task-show-points: task-show-points)
                + (show-solution: show-solution)
                + chosen.named(),
        )
        show: bmim-common
        show ref: task.show-ref

        set std.page(
            header: (header.exercise),
            footer: (footer.exercise)(course, title),
        )

        show heading.where(level: 1): heading-colored

        (titleblock.exercise)(course, title, authors, date)

        body

        if show-solution == "bottom" {
            pagebreak(weak: true)
            task.solution-bottom
        }
    }
}

#let lab(
    title: none, // either [Title] , or ([Topic], [Title])
    course: none, // [Course Name] or ([Course Name], [Short Course Name])
    authors: none, // array of str or content
    date: datetime.today(), // datetime or content
    show-solution: none, // none, "inline", "bottom"
    ..chosen,
) = {
    body => {
        option-set(
            (task-show: task.style-enum)
                + (task-wrap-counter: (counter(heading), 1))
                + if "logo-with-text" not in chosen.named() {
                    (logo-with-text: true)
                }
                + (show-solution: show-solution)
                + chosen.named(),
        )
        show: bmim-common
        show ref: task.show-ref

        set std.page(
            header: header.lab,
            footer: (footer.lab)(course, title),
        )

        set heading(numbering: "1.")
        show heading.where(level: 1): heading-colored
        (titleblock.lab)(course, title, authors, date)

        body

        if show-solution == "bottom" {
            pagebreak(weak: true)
            task.solution-bottom
        }
    }
}

#let lecture(
    course: none, // [Course Name] or ([Course Name], [Short Course Name])
    authors: none, // array of str or content
    date: datetime.today(), // datetime or content
    ..chosen,
) = {
    body => {
        set std.page(
            header: header.lecture,
            footer: (footer.lecture)(),
        )

        body
    }
}

#let poster(
    title: none, // str or content
    authors: none, // array of str or content
    affiliations: none, // array of str or content
    paper: "a2", // paper size
    orientation: "landscape", // "landscape", "portrait"
    date: datetime.today(), // datetime or content
    event: none, // str or content
    location: none, // str or content
    contact: none, // str or content
    ..chosen, // other options: theme, size, etc
) = {
    body => context {
        option-set(
            chosen.named()
                + if "size" not in chosen.named() { (size: 20pt) }
                + if "logo-with-text" not in chosen.named() {
                    (logo-with-text: true)
                },
        )
        let opts = options.final()

        show: bmim-common

        set document(title: title)

        let base_margin = 3em
        let margin = (top: 16%, x: base_margin, bottom: 7%)

        set std.page(
            paper: paper,
            columns: if orientation == "landscape" { 3 } else { 2 },
            flipped: orientation == "landscape",
            margin: margin,
            header-ascent: base_margin,
            header: context {
                let mx = getmarginx()
                layout(l => move(dx: -mx, box(
                    height: l.height,
                    width: page.width,
                    fill: opts.theme.primary,
                    pad(x: mx, top: mx, bottom: mx / 2)[
                        #grid(
                            // columns: (61.8%, 38.2%),
                            columns: (2fr, 1fr),
                            gutter: mx,
                            [
                                // Title and Authors
                                #align(left + top)[
                                    #set par(leading: .5em)
                                    #text(
                                        size: 2.8em,
                                        fill: white,
                                        font: "Noto Sans",
                                        weight: "bold",
                                        hyphenate: false,
                                        title,
                                    )
                                    #block(
                                        above: 1.5em,
                                        height: .5em,
                                        width: 38.2%,
                                        fill: opts.theme.lolight,
                                    )
                                    #block(above: 2em)[
                                        #text(
                                            size: 1.3em,
                                            fill: white,
                                            font: "Noto Sans",
                                            hyphenate: false,
                                            authors.join([\ ]),
                                        )
                                    ]
                                    #block(above: 1em)[
                                        #text(
                                            size: 1em,
                                            fill: white,
                                            font: "Noto Sans",
                                            hyphenate: false,
                                            affiliations.join([\ ]),
                                        )
                                    ]
                                ]
                            ],
                            grid.vline(stroke: .125em + white),
                            [
                                //  Logos
                                #align(center + horizon)[
                                    #image("../assets/logos.pdf", height: 100%)
                                ]
                            ],
                        )
                    ],
                )))
            },
            footer: context {
                let mx = getmarginx()
                layout(l => move(dx: -mx, box(
                    height: l.height,
                    width: page.width,
                    inset: (x: mx, y: 0.7em),
                    fill: opts.theme.primary,
                )[
                    #set text(size: .7em, fill: white)
                    #grid(
                        columns: (auto, auto, 1fr, 20%, 1fr, auto, auto),
                        gutter: 1em,
                        // fill: blue,
                        // gutter: mx,
                    )[
                        #let vcard = "
                      BEGIN:VCARD
                      VERSION:4.0
                      N:Ecklebe;Stefan;;Dr.-Ing.;
                      FN:Dr.-Ing. Stefan Ecklebe
                      ORG:UMIT-TIROL
                      ROLE:Universitätsassistent
                      TEL;TYPE=work,voice;VALUE=uri:tel:+4350-8648-3832
                      ADR;TYPE=work;LABEL=\"Eduard-Wallnöfer-Zentrum 1\nA-6060 Hall n Tirol\nÖsterreich\":;;Eduard-Wallnöfer-Zentrum 1;Hall in Tirol;;A-6060;Austria
                      EMAIL:stefan.ecklebe@umit-tirol.at
                      REV:20260212T221110Z
                      END:VCARD
                      "
                        // TITLE:Redaktion & Gestaltung
                        // PHOTO;MEDIATYPE=image/jpeg:http://commons.wikimedia.org/wiki/File:Erika_Mustermann_2010.jpg
                        #qr-code(
                            height: 100%,
                            quiet-zone: false,
                            dark-color: white,
                            light-color: opts.theme.primary,
                            vcard,
                        )
                    ][
                        #grid(
                            columns: 2,
                            rows: auto,
                            gutter: .55em,
                            // TODO take these from args
                            [*Kontakt:*],
                            [Dr.-Ing. Stefan Ecklebe
                                // , Universitätsassistent
                            ],

                            [*Adresse:*],
                            [Eduard-Wallnöfer-Zentrum 1,\ A-6060 Hall in Tirol,
                                Österreich],

                            [*Tel.*], [+4350 8648 3832],
                            [*Email:*], [#contact],
                        )
                    ][
                        // filler
                    ][
                        #set par(justify: false)
                        #set align(center + horizon)
                        #set text(weight: "bold")
                        Diese Forschung wurde durch den Österreichischen
                        Wissenschaftsfonds (FWF) [I 6519-N] finanziert.
                        // #set par(leading: .7em)
                        // Institut für Automatisierungs- und Regelungstechnik\
                        // UMIT TIROL –
                        // // Die Tiroler Privatuniversität\
                        // Private Universität für Gesundheitswissenschaften \
                        // und -technologie GmbH \
                        // https://iace.umit-tirol.at
                    ][
                        // filler
                    ][
                        #set align(center)
                        #image("../assets/iace_white.svg", height: 50%)
                        #image("../assets/logo_umit_white.svg", height: 40%)
                    ][
                        #qr-code(
                            height: 100%,
                            quiet-zone: false,
                            dark-color: white,
                            light-color: opts.theme.primary,
                            "https://umit-tirol.at/iace",
                        )
                    ]
                ]))
            },
            footer-descent: base_margin,
            background: [
                #place(center + bottom, {
                    image("../assets/bg.jpg", width: 100%)
                })
                #place(bottom, {
                    box(width: 100%, height: 52%, fill: gradient.linear(
                        white,
                        white.transparentize(30%),
                        angle: 90deg,
                    ))
                })
            ],
        )
        // format headings
        set heading(numbering: none)
        show heading: set text(fill: opts.theme.neutral-darkest)
        show heading.where(level: 1): set text(size: 1.2em)


        set list(marker: ([‣], [--]))

        body
    }
}

#let report(
    title: none, // str or content
    course: none, // either [Course Name] , or ([Course Name], [Short Course Name])
    authors: none, // array of str or content
    date: datetime.today(), // datetime or content
    ..chosen, // other options: theme, logo-with-text, size, lang, etc
) = {
    body => context {
        option-set(
            chosen.named()
                + if "logo-with-text" not in chosen.named() {
                    (logo-with-text: true)
                },
        )
        show: bmim-common
        set heading(numbering: none)
        set text(spacing: 100%)
        set page(
            columns: 2,
            header: header.report,
            footer: (footer.report)(course, title),
        )

        show heading.where(level: 2): set text(
            weight: "light",
            size: options.final().size,
        )
        show heading.where(level: 2): emph

        (titleblock.report)(course, title, authors, date)

        body
    }
}

#let workbook(
    course: none,
    authors: none,
    show-solution: none, // none, "inline", "bottom"
    task-show-points: false,
    date: datetime.today(),
    ..chosen,
) = {
    body => {
        option-set(
            (task-show: task.style-heading.with(lvl: 2))
                + (show-solution: show-solution)
                + (task-wrap-counter: (counter(heading), 1))
                + (task-show-points: task-show-points)
                + chosen.named()
                + if "logo-with-text" not in chosen.named() {
                    (logo-with-text: true)
                },
        )
        show: bmim-common
        show ref: task.show-ref

        (titleblock.workbook)(course, authors, date)

        set page(
            header: header.workbook,
            footer: (footer.workbook)(course),
            numbering: "1",
        )

        set outline(depth: 1)
        let headings-on-odd-page(it) = {
            show heading.where(level: 1): it => {
                pagebreak(to: "odd")
                it
            }
            it
        }
        set heading(numbering: "1.1")
        show heading.where(level: 2): heading-colored
        show heading.where(level: 1): it => context {
            set block(inset: (y: 2em))
            show: strong
            show: block
            if it.numbering == none {
                it.body
                return
            }
            let n(..c) = numbering(it.numbering, ..c)
            [
                #set text(1.3em)
                Kapitel #n(..counter(heading).get())
                #v(1em)
                #set text(1.5em)
                #it.body
            ]
        }

        outline()
        counter(page).update(1)

        show: headings-on-odd-page

        body

        if show-solution == "bottom" {
            pagebreak(weak: true)
            task.solution-bottom
        }
    }
}
