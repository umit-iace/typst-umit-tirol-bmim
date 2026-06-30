#import "/src/lib.typ" as bmim: example, hint, backmatter

#show: bmim.lecture(
  lang: "de",
  course: ("Vorlesung", "VL"),
  authors: ("John Doe", "Jane Doe", "Max Mustermann"),
  date: datetime(day: 1, month: 3, year: 2024),
)

= Ein Kapitel

#lorem(100)

== Ein Abschnitt

=== Ein Unterabschnitt

#lorem(50)

==== Ein Untertunterabschnitt

#lorem(50)

===== Ein Absatz
#lorem(100)

===== Ein anderer Absatz
#lorem(150)

==== Noch ein Untertunterabschnitt

#lorem(150)

=== Noch ein Unterabschnitt

#lorem(50)

== Noch ein Abschnitt

#lorem(150)

= Strukturen

== Auflistungen

+ #lorem(40)
+ #lorem(40)
+ #lorem(40)

- #lorem(30)
- #lorem(30)
- #lorem(30)

== Umgebungen


#example(
  lorem(150)
)

#hint(
  lorem(150)
)

TODO: Lemma, Satz, Definition, Übung, Beispiel, Erinnerung, Anmerkung, Tabelle, Abbildung

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

#show: backmatter

= Details

*TODO:* "Kapitel" sollte ab hier Anhang heißen, Anhang sollte in Gliederung abgetrennt werden.

// #lorem(50)

== Mehr Details

#lorem(1500)

== Andere Details

#lorem(500)

= Das ließt niemand mehr


#bibliography("sources.bib", title: "Literatur")
