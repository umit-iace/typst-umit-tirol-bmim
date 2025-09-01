#import "../../src/lib.typ": *

#show: bmim-theme.with(
  variant: "exam",
  title: "Control me",
  type: "Klausur",
  lang: "en",
  course: "Advanced Control",
  course-short: "AC",
  authors: ("Author1", "Author3", "Author3"),
  wUmitLogo: false,
  with-solution: true,
  with-points: true,
  sol-at-end: true,
)

= Section 1

#lorem(20)

== Subsection 1

#lorem(50)

- #task(points: 10, task: [
  Test Problem

  Take a look in the solution
], solution: [
  Lösung steht hier ganz fett mit $1+1=2$.
])

=== Subsubsection 1

#lorem(80)

#pagebreak()

== Subsection 2 <bmim:nonumber>

#set enum(full: true, numbering: wrapped-enum-numbering("A"))

Group axioms:
+ #enum-label("ax:ass")Associativity
+ #enum-label("ax:id")Existence of identity element
+ #enum-label("ax:inv")Existence of inverse element


#set enum(numbering: wrapped-enum-numbering("1.a"), full: true)
#set math.equation(numbering: "(1.1)")
Another important list:
+ Newton's laws of motion are three physical laws that relate the motion of an object to the forces acting on it.
  + A body remains at rest, or in motion at a constant speed in a straight line, unless it is acted upon by a force.
  + The net force on a body is equal to the body's acceleration multiplied by its mass
  + #enum-label[newton-third]If two bodies exert forces on each other, these forces have the same magnitude but opposite directions
+ #enum-label[hook1] Another important force is hooks law:
  $ arrow(F) = -k arrow(Delta x) $ <eq:hook> #enum-label[hook2]


We covered the three group axioms @ax:ass[], @ax:id[] and @ax:inv[].

It is important to remember Newton's third law @newton-third, and Hook's law @hook1. In @hook2 we gave Hook's law in @eq:hook.

#important[Test]

#tip[Test]

#example[Test]

#hint[Test]

= Section

#lorem(20)

- #task(points: 20, task: [
  Test Problem 2

  Take a look in the solution
], solution: [
  Lösung steht hier ganz fett mit $1+5=6$.
])
