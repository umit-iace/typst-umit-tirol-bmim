#import "./preamble.typ": *

#let my-title-slide(info) = grid(
  columns: (3fr, 2fr),
  rows: 100%,
  block(
    width: 100%,
    height: 100%,
    fill: info.theme.primary,
    inset: (x: 28pt, y: 32pt),
    {
      set align(left + horizon)
      set par(justify: false, leading: 0.4em)
      set text(fill: white)
      text(size: 11pt, weight: "semibold", upper(info.conference))
      v(0.6em)
      text(size: 26pt, weight: "bold", info.title)
      if info.subtitle != none {
        v(0.4em)
        text(size: 15pt, info.subtitle)
      }
      line(length: 30%, stroke: 1.2pt + info.theme.highlight)
      text(size: 11pt, info.authors.join[, ])
      v(0.3em)
      text(size: 8pt, info.institution.join[\ ])
      place(bottom + left, dy: 12pt, text(size: 12pt)[
        #info.date.display("[day].[month].[year]"), #info.location
      ])
    },
  ),
  block(width: 100%, height: 100%, clip: true, {
    image("./../assets/background_bettelwurf.jpg", width: 100%, height: 100%, fit: "cover")
    place(bottom + right, dx: -20pt, dy: -20pt, stack(
      dir: ltr,
      spacing: 14pt,
      image("./../assets/logo_lfui_color_invert.png", height: 36pt),
      image("./../assets/logo_umit_white_en.svg", height: 30pt),
    ))
  }),
)

#show: bmim.slides(
  title: (
    "Control design strategies for better results that take a quite a long title to explain what's really happening",
    "Control it better"
  ),
  subtitle: "Because reactions are bad",
  lang: "en",
  conference: "94th Conference of Applied Mathematics and Slide Care",
  institution: (
    [$zwj^(1)$Institut für Automatisierungs und Regelungstechnik, UMIT TIROL, Hall in Tirol, Österreich],
    [$zwj^(2)$Institut für Mechatronik, Universität Innsbruck, Innsbruck, Österreich],
  ),
  location: "Irgendwo",
  authors: (
    [#text(weight: "bold", size: 1.05em)[Jane Doe$zwj^(1)$]],
    [John Doel$zwj^(2)$],
    [John Doele$zwj^(2)$],
    [John Doeles$zwj^(2)$],
    [John Doel$zwj^(2)$],
    [John Doel$zwj^(2)$],
    [Max Mustermann$zwj^(1)$]
  ),
  authors-short: [Doel, Doele, Doeles, et al.],
  date: datetime(day: 31, month: 12, year: 2024),
  logo: (
    left: pad(
      top: -8.0pt,
      left: 21pt,
      image("./../assets/logo_lfui_color_invert.png", height: 30pt)
    ),
  ),
  progress-animation: (
    slides: true,
    section: true,
  ),
  title-slide: my-title-slide,
)

#include "content/slides.typ"
