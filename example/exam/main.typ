#import "../../src/lib.typ": *

#show: bmim-theme.with(
  variant: "exam",
  title: "Control me",
  type: "Klausur",
  lang: "de",
  course: "Advanced Control",
  course-short: "AC",
  authors: ("Author1", "Author3", "Author3"),
  wUmitLogo: false,
  with-solution: false,
  with-points: true,
  sol-at-end: true,
)

= Aufgabe 1 <bmim:nonumber>

Das Eingangs-Ausgangsverhalten eines Systems wird durch die Übertragungsfunktion
$
  G(s) & = frac(s+2, 2 s^(2) - 2 s + 1)
$
beschrieben.

#set enum(full: true, numbering: wrapped-enum-numbering("a)"))

+ #task(points: 20, task: [
  Geben Sie eine Realisierung der Übertragungsfunktion in Regelungsnormalform an.
], solution: [
  Regelungsnormalform:
  $
    dot(bold(x)) & = mat(0, 1; -frac(1,2), 1) bold(x) + mat(0; 1) u \
    y & = mat(1, frac(1, 2)) bold(x)
  $
])

+ #task(points: 20, task: [
  Ist die interne Dynamik des Systems stabil?
  Begründen Sie Ihre Antwort.
], solution: [
  Die Eigenwerte der internen Dynamik entsprechen den Zählernullstellen.
  Diese sind durch die Lösungen von $s+2=0$ durch $s=-2$ gegeben und somit ist die interne Dynamik in Folge des negativen Realteils stabil.
])

= Aufgabe 2 <bmim:nonumber>

Betrachtet wird das System
$
  dot(x)_1 = x_2, #h(5em)
  dot(x)_2 = x_3, #h(5em)
  dot(x)_3 = x_2 - x_3 + u
$
mit dem Ausgang
$
  y & = x_1 + 2 x_2 + x_3.
$

#set enum(full: true, numbering: wrapped-enum-numbering("a)"))

+ #task(points: 20, task: [
  Wie heißt die spezielle Zustandsdarstellung in der das System gegeben ist?
], solution: [
  Das System liegt in Regelungsnormalform vor.
])

+ #task(points: 20, task: [
  Welchen relativen Grad besitzt das System?
  Begründen Sie Ihre Antwort.
], solution: [
  Der relative Grad des Systems ist eins.
  Dies kann entweder direkt aus der Ausgangsmatrix $c^(sans(upright(T)))=(1,1,1)$ abgelesen werden oder aber durch Differentiation des
  Ausgangs:
  $
    dot(y) & = dot(x)_1 + 2 dot(x)_2 + dot(x)_3 = x_2 + 2 x_3 + x_2 - x_3 + u = 2 x_2 + x_3 + u.
  $
])

#context {
  let nonumber-cnt = counter("bmim-nonumber").final().at(0)
  for i in range(0, nonumber-cnt) {
    pagebreak(to: "odd")
    pagebreak(to: "odd")
  }
}
