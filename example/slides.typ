#import "@local/typst-umit-tirol-bmim:0.2.0" as bmim: *

#show: bmim.slides(
  title: ("Sehr sehr langer Titel", "Kurztitel"),
  subtitle: "Mit besonderen Datenpunkten",
  lang: "de",
  conference: "Test 2018",
  institution: "Institut für Automatisierungs und Regelungstechnik",
  authors: ("John Doe", "Jane Doe", "Max Mustermann"),
  date: datetime(day: 1, month: 3, year: 2024),
)

#title-slide()

= Motivation <touying:skip>

== Motivation

A slide with a motivation.

#lorem(50)

#outline-slide(title: "")

= Modeling

== Modeling

A slide with *important information* and a citation //@Woittennek2013 and another @Mayer2025


= Controller

== Controller

A slide with *important information*.

#lorem(50)

#pause

// === Highlight
// This is #highlight(fill: bmimblue)[highlighted in blue]. This is #highlight(fill: bmimpurple)[highlighted in yellow]. This is #highlight(fill:
// bmimgrey)[highlighted in green]. This is #highlight(fill: bmimred)[highlighted in red].

// == Implementation

// #quote(
//   attribution: [from the Henry Cary literal translation of 1897 | *Noticed the custom quotes?*],
// )[
//   ... I seem, then, in just this little thing to be wiser than this man at
//   any rate, that what I do not know I do not think I know either.
// ]

= Summary

== Admonitions

A slide with admonitions

// #definition[Test]

// #example[Test]

// #task[Test]

