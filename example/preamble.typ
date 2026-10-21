#import "/src/lib.typ" as bmim: task, enum-label, wrapped-enum-numbering, mainmatter, backmatter, abstract, poster-box, translated-month

// various environments
#import "@preview/rustycure:0.2.0": qr-code
#import "@preview/touying:0.8.0": *
#import "@preview/theorion:0.6.0": *
#import cosmos.clouds: *

// own titleblock
#let tb(args) = context {
  let course = if type(args.course) == array { args.course.at(0) } else { args.course }
  set align(center)
  rect(
    width: 100%,
    inset: (top: 0.2em, bottom: 0.2em, left: 0.2em, right: 0.2em),
    stroke: 1pt,
    rect(
      width: 100%,
      inset: (top: 1em, bottom: 1em),
      stroke: (paint: black.lighten(20%), thickness: 1.3pt),
      strong[
        Labor \
        #sym.hyph \
        #course \
        #line(length: 95%)
        #if type(args.title) == array {
          args.title.at(0)
          linebreak()
          args.title.at(1)
        } else {
          args.title
        }
      ]
    )
  )
  grid(
    columns: 2,
    gutter: 0.75em,
    align: (right, left),
    [
      #if args.show-solution != none {
        set text(bmim.color.red)
        strong[
          #args.spell.with #args.spell.sol,
        ]
      }
      #args.spell.ho:
    ],
    grid(
      row-gutter: 0.5em,
      ..args.authors.map(author => text(author)),
    ),
    [
      #args.spell.lc:
    ],
    [
      #args.date.day(). #translated-month(args.date, args.lang) #args.date.year()
    ],
  )
}

// own admonition block
#let adm-render(
  border: bmim.color-cd2026.blue,
  prefix: none,
  title: "",
  full-title: auto,
  ..args,
  body,
) = context {
  block(width: 100%, ..args)[
    #box(
      width: 100%,
      fill: white,
      stroke: (
        left: 2pt+border,
        bottom: 2pt+border,
      ),
      radius: 1pt,
      inset: (top: 0em, x: 0.5em, bottom: 0.5em),
    )[
      #box(
        fill: border,
        outset: (x: 0.59em, y: 0.3em),
      )[#text(fill: white, strong(full-title))]
      #sym.space
      #indent-repairer[#body]
    ]
  ]
}

#let (example-counter, example-box, example, show-example) = make-frame(
  "example",
  theorion-i18n-map.at("example"),
  counter: none,
  render: adm-render,
)

#let (important-counter, important-box, important, show-important) = make-frame(
  "important",
  theorion-i18n-map.at("important"),
  counter: none,
  render: adm-render,
)

#let (tip-counter, tip-block, tip, show-tip) = make-frame(
  "tip",
  theorion-i18n-map.at("tip"),
  counter: none,
  render: adm-render,
)

#let (hint-counter, hint-box, hint, show-hint) = make-frame(
  "tip",
  "Tip",
  counter: none,
  render: adm-render,
)

#let example = example.with(numbering: none, border: bmim.color.yellow)
#let important = important.with(numbering: none, border: bmim.color.red)
#let tip = tip.with(numbering: none, border: bmim.color.blue)
#let hint = hint.with(numbering: none, border: bmim.color.green)

// Poster: contents of the boxes, shared by poster-landscape.typ and
// poster-portrait.typ, the same boxes, only the layout differs

// gray placeholder for a figure
#let poster-placeholder(height, label: [Figure]) = rect(
  width: 100%,
  height: height,
  fill: luma(225),
  stroke: luma(185),
  align(center + horizon, text(luma(120), label)),
)

#let poster-caption(body) = align(center, text(0.8em, emph(body)))

// topics on the left, details on the right
#let poster-topics(..items) = grid(
  columns: (35%, 1fr),
  gutter: 0.6em,
  align: horizon,
  ..items.pos().map(((topic, points)) => (
    rect(width: 100%, inset: 0.6em, radius: 0.4em, fill: bmim.color-cd2026.blue,
      align(center, text(white, topic))),
    rect(width: 100%, inset: 0.6em, radius: 0.4em, fill: luma(215),
      text(0.8em, list(..points))),
  )).flatten()
)

#let poster-boxes = (
  // text and an image side by side
  motivation: poster-box[Motivation][
    #grid(
      columns: (3fr, 2fr),
      gutter: 0.8em,
      [
        #lorem(25)
        - #lorem(6)
        - #lorem(8)
        - #lorem(5)
      ],
      [
        #image("/assets/background_umit.jpg", width: 100%)
        #poster-caption[#lorem(3)]
      ],
    )
  ],

  // topics with their details
  topics: poster-box[Research Topics][
    #poster-topics(
      ([Modelling], ([#lorem(4)], [#lorem(3)], [#lorem(4)])),
      ([Control Design], ([#lorem(5)], [#lorem(4)])),
      ([Diagnosis], ([#lorem(4)], [#lorem(5)])),
    )
  ],

  // text with a list and a figure
  approach: poster-box[Approach][
    #grid(
      columns: (3fr, 2fr),
      gutter: 0.8em,
      [
        #lorem(12)
        - #lorem(3)
        - #lorem(2)
        - #lorem(3)
        #lorem(5)
      ],
      poster-placeholder(6em),
    )
  ],

  // a figure and a table side by side
  setup: poster-box[Experimental Setup][
    #grid(
      columns: (1fr, 1fr),
      gutter: 0.8em,
      align: horizon,
      [
        #poster-placeholder(6em)
        #poster-caption[#lorem(4)]
      ],
      table(
        columns: 2,
        stroke: none,
        table.hline(),
        [Parameter], [Value],
        table.hline(stroke: 0.5pt),
        [Length $l$], [1.5 m],
        [Diameter $d$], [0.01 m],
        [Flow $dot(V)$], [14 l/min],
        [Dead time $tau$], [0.5 s],
        table.hline(),
      ),
    )
  ],

  // equations
  model: poster-box[Model][
    #lorem(8)
    $
      dot(bold(x))(t) & = bold(A) bold(x)(t) + bold(b) u(t), \
      y(t) & = bold(c)^top bold(x)(t - tau)
    $
    #lorem(15)
  ],

  // a figure with a caption and some text
  results: poster-box[Results][
    #poster-placeholder(6em)
    #poster-caption[#lorem(5)]
    #align(center)[
      *#lorem(2)* \
      $u(t) = -bold(k)^top bold(x)(t) + v(t)$
    ]
  ],

  // a large image
  outlook: poster-box[Outlook][
    #image("/assets/background_bettelwurf.jpg", width: 100%)
    #poster-caption[#lorem(4)]
  ],
)

// box in the shape of a right angle: heading and text over the full width,
// below on one side the figure, `inner` fills the corner
#let poster-angle-box(inner, at: left, widths: (1fr, 1fr)) = bmim.poster-angle(
  heading: [Methods],
  top: [
    #lorem(20)
    - #lorem(4)
    - #text(bmim.color.yellow)[#lorem(3)]
    - #text(bmim.color.green)[#lorem(4)]
  ],
  side: [
    #poster-placeholder(10em)
    #poster-caption[#lorem(6)]
  ],
  inner: inner,
  at: at,
  widths: widths,
)
