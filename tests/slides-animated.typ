#import "/src/lib.typ" as bmim 
#import "@preview/touying:0.8.0": touying-slide-wrapper, touying-slide, pause, uncover

#show: bmim.slides(
  title: (
    "Control design strategies for better results",
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
    [Max Mustermann$zwj^(1)$]
  ),
  authors-short: [Doel et al.],
  date: datetime(day: 1, month: 3, year: 2024),
  bib-as-footnote: true,
  handout: false,
  notes: none,
)

= Animations

#lorem(10)
#pause
#lorem(10)
#pause
#lorem(10)

#uncover("1-")[Important Note should always be visible]

= Citation Tests

A slide with *important information* @netwok2020
#pause
@netwok2021
#pause
a dramatic pause @netwok2022
#pause
and a citation @netwok2023
#pause
and one more @netwok2024
#pause
and one more @netwok2025
#pause
#lorem(10)
#pause
#lorem(10)
#pause


== References

#bibliography(title: none, "../example/sources.bib")

