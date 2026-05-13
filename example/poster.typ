#import "/src/lib.typ" as bmim: poster-box
// #set page(width:5cm, height:7cm, margin: 10pt)
#set page("a5", margin: 10pt, flipped: false)

#let possibly-apply(maybe-func) = if type(maybe-func) == function { maybe-func() } else { maybe-func }

#let split(hor, ..args) = {
  let splits = (1fr,)*args.pos().len()
  let layout = if hor {(columns: splits, rows: 1fr)} else {(rows: splits,
  columns: 1fr)}
  grid(
    ..layout,
    stroke: .1pt,
  // ..args.named(),
    ..for arg in args.pos() {
      (possibly-apply(arg),)
    }
  )
}

#let hs(..args) = split(true, ..args)
#let vs(..args) = split(false, ..args)


#let pbox(..args) = box(
  inset: 5pt,
  if args.pos().len() != 0 or args.named() != (:) {
    args.pos().first()
  } else {
    layout(l =>
      [
        #metadata(l)<bmim-poster-box>
        #box(fill:blue, width:1pt, height:1pt)
      ]
    )
  }
)

#let pcount = counter("bmim-poster-box-counter")

#let put(body) = context {
  pcount.step()
  let meta = query(<bmim-poster-box>).at(pcount.get().first())
  let size = meta.value
  let where = meta.location().position()
  // panic(size)
  place(top+left, dx: where.x - page.margin, dy: where.y - page.margin,
    box(..size, body)
)

}

#let layout = vs(
  hs(
    pbox, pbox, pbox
    // pbox[a], pbox[b], pbox[c]
    // pbox[lorem or smth], pbox[ipsum]
  ),
  pbox,
  hs(pbox, pbox)
  // pbox[haha],
)

#layout
// #panic(layout)


#put[
= First
#lorem(20)
]
#put[
= Second
#lorem(20)
]
#put[
= Third
#lorem(20)
]
#put[
= Fourth
#lorem(20)
]
#put[
= Fifth
#lorem(20)
]
#put[
= Sixth
#lorem(20)
]
// #put[
// = Seventh
// #lorem(20)
// ]

// #show: bmim.poster(
//   title:[],
//   authors:(
//     [John Doe & Jane Doe],
//     [Max Mustermann]
//   ),
//   contact: [`iace.office@umit-tirol.at`],
//   event: [Wichtiges Event],
//   location: [UMIT TIROL, Hall in Tirol],
//   // orientation: "landscape",
//   orientation: "portrait",
//   // layout: layout,
// )

// #poster-box[A Box][
//   Hey!

//   #lorem(30)
// ]

// #poster-box(height:1fr)[Another Box][
//   Do try @tab:try.
//   #figure(
//     table(
//       columns: 4,
//       ..(context{counter("a").step(); str(counter("a").get().first())},)*8,
//     ),
//     caption: [Try me! #lorem(20)],
//   ) <tab:try>
// ]
// #colbreak()

// #poster-box[Oh, a box][
//   #lorem(30)
// ]
