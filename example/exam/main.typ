#import "../src/lib.typ": *

#show: bmim-theme.with(
  variant: "exam",
  title: "Control me",
  lang: "de",
  course: "Advanced Control",
  authors: ("Author1", "Author3", "Author3"),
  wUmitLogo: true,
)

#outline()

= Section

#lorem(20) @netwok2020

== Subsection

#lorem(50)

=== Subsubsection

#lorem(80)

#pagebreak()

#lorem(80)

= Section

#lorem(20) @netwok2020

#show: backmatter

= Appendix Section

#lorem(80)

= Appendix Section

#lorem(80)

#important[Test]

#tip[Test]

#example[Test]

#hint[Test]

#bibliography("./../../assets/sources.bib", title: "Literatur")
