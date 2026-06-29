#import "/src/lib.typ" as bmim

#show: bmim.lecture(
  lang: "de",
  course: ("Vorlesung", "VL"),
  authors: ("John Doe", "Jane Doe", "Max Mustermann"),
  date: datetime(day: 1, month: 3, year: 2024),
)

= Wiederholung

#lorem(2)

== Ganz was neues

#lorem(150)
#lorem(150)
#lorem(150)

== oder doch nicht

#lorem(50)
#lorem(50)
#lorem(50)


= Jetzt was neues

#lorem(250)@netwok2020
#lorem(250)
#lorem(250)

== Erstmal Grundlagen

#lorem(500)
#lorem(500)
#lorem(500)

= Jetzt was anderes neues

#lorem(400)
#lorem(400)

== Keine Grundlagen

#lorem(250)
#lorem(250)
#lorem(250)

== Doch Grundlagen

#lorem(250)
#lorem(250)

#bibliography("sources.bib", title: "Literatur")
