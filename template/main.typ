#import "@preview/typst-umit-tirol-bmim-practical:0.1.0": *

#show: bmim-theme.with(
  title: "Control me",
  type: "Labor",
  lang: "de",
  course: "Advanced Control",
  authors: ("Author1", "Author3", "Author3"),
  wUmitLogo: true,
)

#outline()

= Section

#lorem(20) @netwok2020

#show: backmatter

= Appendix Section

#lorem(80)

= Appendix Section

#lorem(80)

#bibliography("sources.bib", title: "Literatur")
