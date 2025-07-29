#import "colors.typ": *
#import "utils.typ": *

#let header-general(theme, wUmitLogo, lang) = context {
  pad(
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
}

#let footer-practical(type, course, title, with-solution, lang) = context {
    set text(size: 11pt)
    line(length: 100%, stroke: 0.5pt)
    if calc.odd(here().page()) [
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
}

#let footer-exam(type, course, title, with-solution, lang) = context {
    set text(size: 11pt)
    line(length: 100%, stroke: 0.5pt)
    if calc.odd(here().page()) [
      #type - #course #if with-solution {text(bmimred)[#dictSpell.at(lang).at("with") #dictSpell.at(lang).at("sol")]}
      #h(1fr)
      Matrikelnr: #box(height: -1pt)[#line(length: 25%)]
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
      Matrikelnr: #box(height: -1pt)[#line(length: 25%)]
      #h(1fr)
      #type - #course #if with-solution {text(bmimred)[#dictSpell.at(lang).at("with") #dictSpell.at(lang).at("sol")]}
    ]
}

#let title-practical(type, course, title) = context {
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
}

#let title-exam(type, course) = context {
  text(
    weight: "bold",
    [
      #type - #course
    ]
  )
}

#let subtitle-practical(authors, with-solution, lang) = context {
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

#let subtitle-exam(authors, date, lang) = context {
  grid(
    columns: (1.25fr, 1fr),
    gutter: 0.5em,
    grid.cell(
      colspan: 2,
      v(0.5em),
    ),
    grid.cell(
      text(
      )[
        #set align(right)
        #text(weight: "bold")[#dictSpell.at(lang).at("on") #date.day(). #translatedMonth(date, lang) #date.year(), #dictSpell.at(lang).at("ho"):]
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
          ..authors.map(author => text(weight: "bold", fill: black, author)),
        )
      ]
    ),
    grid.cell(
      colspan: 2,
      v(0.75em),
    ),
    grid.cell(
      text(
      )[
        #set align(right)
        Name: #box(height: -1pt)[#line(length: 73%)] #h(2em)
      ]
    ),
    grid.cell(
      text(
      )[
        #set align(left)
        Matrikelnummer: #box(height: -1pt)[#line(length: 50%)]
      ]
    ),
    grid.cell(
      colspan: 2,
      v(0.75em),
    ),
  )
}

#let notes-exam() = context {
  rect(
    width: 100%,
    radius: 0%,
    inset: (top: 0.3em, bottom: 1em),
    stroke: (paint: black.lighten(20%), thickness: 0.4pt),
  )[
    #set list(spacing: 1.3em, tight: false)
    #text(size: 10pt)[
      #text(weight: "bold")[Hinweise]
      #v(0.75em)
      #pad(left: 1.4em)[
        - Die Prüfung umfasst Aufgaben, die Bearbeitungszeit beträgt .
        - Es können insgesamt Punkte erreicht werden.
        - Zugelassene Hilfsmittel:
          - #text(weight: "bold")[ein handschriftlich] beschriebener A4 Zettel; #text(weight: "bold")[Muss] am Ende der Klausur abgegeben werden.
          - #text(weight: "bold")[keine] weiteren Unterlagen
          - #text(weight: "bold")[keine] elektronischen Geräte
        - Bitte schreiben Sie #text(weight: "bold")[leserlich] und geben Sie den #text(weight: "bold")[Lösungsweg] vollständig an.
        - Schreiben Sie #text(weight: "bold")[nicht] mit Bleistift und #text(weight: "bold")[nicht] mit Rotstift.
      ]
    ]
  ]
}
