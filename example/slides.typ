#import "@local/typst-umit-tirol-bmim:0.2.0" as bmim: *

#show: bmim.slides(
  title: ("Sehr sehr langer Titel", "Kurztitel"),
  subtitle: "Mit besonderen Datenpunkten",
  lang: "de",
  conference: "Conference Test",
  institution: "Institut für Automatisierungs und Regelungstechnik",
  authors: ("John Doe", "Jane Doe", "Max Mustermann"),
  date: datetime(day: 1, month: 3, year: 2024),
  bib: bibliography(title: none, "sources.bib"),
)

#title-slide()

= Motivation <touying:skip>

== Motivation

A slide with a motivation.

#lorem(50)

#outline-slide(title: "")

= Modeling

== Modeling

A slide with *important information* and a citation @netwok2020.


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

- Next Steps

== Admonitions

A slide with admonitions

#example[Test]

#hint[Test]

== References

#magic.bibliography(title: none)

