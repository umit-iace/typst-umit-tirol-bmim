#import "./preamble.typ": *

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

#bmim.title-slide()

= Motivation <touying:skip>

== Motivation

A slide with a motivation.

#lorem(50)

#bmim.outline-slide(title: "Contents")

= Modeling

== Modeling

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
#pause
#pause


= Controller

== Controller

A slide with *important information*.

#lorem(50)

#pause

=== Highlight
This is #highlight(fill: blue)[highlighted in blue]. This is #highlight(fill: yellow)[highlighted in yellow]. This is #highlight(fill:
green)[highlighted in green]. This is #highlight(fill: red)[highlighted in red].

== Implementation

#quote(
  attribution: [from the Henry Cary literal translation of 1897 | *Noticed the custom quotes?*],
)[
  ... I seem, then, in just this little thing to be wiser than this man at
  any rate, that what I do not know I do not think I know either.
]

= Summary

== Summary

- Next Steps @netwok2020

#speaker-note[
  + This is a speaker note.
  + You won't see it unless you use `config-common(show-notes-on-second-screen: right)`
]

== References

#bibliography(title: none, "sources.bib")

#show: appendix

= Appendix <touying:unoutlined>

== Appendix Slide

This slide contains additional content.
