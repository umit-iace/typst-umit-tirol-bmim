#import "/src/lib.typ" as bmim 
#import "@preview/touying:0.8.0": touying-slide-wrapper, touying-slide, pause, uncover, meanwhile, cols, lazy-v

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


= Animation Examples

== Problems with `#v()`

#v(1em)

When putting `#v(1fr)` in front of a `#meanwhile` or `#uncover`
bad things can happen: 
On this slide, the important note on the bottom jumps up and 
is the only thign shown on one slide.

A:
#pause
- B
#pause
- C
#v(1fr)
#meanwhile
Important Note should always be visible

== Solution

#v(1em)

Always make sure to put the `#v(1fr)` *after*  a `#meanwhile` or `#uncover`:

A:
#pause
- B
#pause
- C
#meanwhile
#v(1fr)
Important note should always be visible

== Problems with cols

The touying package offers the cols envrionment for an easy multicol setup
where you can use `lazy-v` to align things: *DO NOT USE ANY ANIMATIONS IN COMBINATION WITH LAZY-V*

#cols(columns: (50%, 50%), lazy-layout: true)[
  #lorem(25)
  #lazy-v(1fr)
  //do not use this
  // #pause 
  Aligned bottom Line
][
  #lorem(50)
  #lazy-v(1fr)
  Aligned bottom Line
]



= Citation Tests

Touying versions below 0.8.0 will crash when using footcites and animations,
now this works:

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

