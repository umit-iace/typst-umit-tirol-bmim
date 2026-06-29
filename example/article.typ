#import "/src/lib.typ" as bmim: important, hint, example, color-cd2026

#show: bmim.article(
  title: [Control of controllable Continua],
  subtitle: [A very demanding task],
  authors: ("John William Frederick Antony McGainson", "Jane Susan Margaret Feed-Back"),
  lang: "en",

)

// todo move to library
#let abstract(body) = {
  set par(leading: .5em)
  set text(font: "Source Sans 3", spacing: 80%, size: 1.1em)
  text(weight: "semibold", fill: color-cd2026.blue)[Abstract.]
  text(style: "normal")[#body]
}

#abstract[
  #lorem(60)
]

= Headings


== Subsection with number

#lorem(50)

=== Paragraph
This one will be shown as inline heading.
#lorem(75)

=== Paragraph
#lorem(90)

== Subsection without number <bmim:nonumber>

#lorem(80)



= Typographic Structures

== Citations

This sentence is important @netwok2020.
#lorem(80)

== Formulas

Some inline math like $2x + 3r = 10$ should suffice
but sometimes you need a block display:
$
x + y = z.
$
#lorem(40)

== Listings

We have different listings. Bullet lists:
- element
- another
Enumerations:
+ Solve the equation for $x$
+ Solve the equation for $y$

== Figures & Tables

At first, have a look at the very nice image in @fig:test. 
#lorem(40)

#figure(
  image("../assets/background_bettelwurf.jpg", width: 100%),
  caption: [This is a very long figure caption. It will appear below the image.
  ],
) <fig:test>


After that you should find the correct number in @tab:try.
#lorem(20)

#figure(
  table(
    columns: 4,
    ..(context{counter("a").step(); str(counter("a").get().first())},)*8,
  ),
  caption: [This is a very long table caption. It will appear above the table.],
) <tab:try>

== Admonitions

#important[#lorem(20)]

#example[#lorem(20)]

#hint[#lorem(40)]

= A section without number <bmim:nonumber>

#lorem(20)

#bibliography("sources.bib", title: "Bibliography")


