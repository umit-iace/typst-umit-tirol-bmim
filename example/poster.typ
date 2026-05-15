#import "/src/lib.typ" as bmim: poster-box
// #set page(width:5cm, height:7cm, margin: 10pt)
#set page("a5", margin: 10pt, flipped: false)

#let possibly-apply(maybe-func) = if type(maybe-func) == function { maybe-func() } else { maybe-func }

#let split(hor, ..args) = {
  let splits = args.named().at("cuts", default: (1fr,)*args.pos().len())
  let layout = if hor {(columns: splits, rows: 1fr)} else {(rows: splits, columns: 1fr)}
  grid(
    ..layout,
    stroke: .1pt,
    ..for arg in args.pos() {
      (possibly-apply(arg),)
    }
  )
}

/// create layout using horizontal and vertical splits
/// optional named argument 'cut' is passed on to `grid`, refer to https://typst.app/docs/reference/layout/grid/#track-size
#let hs(..args) = split(true, ..args)
#let vs(..args) = split(false, ..args)

/// placeholder for poster box content. used as leaf node in layout definition.
/// takes `label` for order-independent content definition at a later point
/// takes _no_ argument, for order-dependent content definition at a later point
#let box(..args) = std.box(inset: 5pt, layout(sz => {
  let meta = metadata(sz)
  if args.pos().len() == 0 [
    #meta<bmim-poster-box>
    #return
  ]
  let arg = args.pos().first()
  if type(arg) == label [
    #meta#arg
  ] else {
    panic("unexpected argument type: " + repr(type(arg)))
  }
}))

/// counter for automatic order-dependent poster box content definition
#let pcount = counter("bmim-poster-box-counter")

/// takes (label, content) for order-independent content definition
/// or (content) for order-dependent content definition
#let box-content(margin: (:), ..args) = context {
  let body = args.pos().last()
  let meta = none
  if args.pos().len() == 1 {
    pcount.step()
    meta = query(<bmim-poster-box>).at(pcount.get().first())
  } else {
    let lbl = args.pos().first()
    meta = query(lbl).first(default: none)
    if meta == none {
      panic("label: <"+str(lbl)+ "> not assigned to empty poster box")
    }
  }

  let size = meta.value
  let where = meta.location().position()
  place(top+left, dx: where.x - page.margin, dy: where.y - page.margin,
    std.box(..size, inset: margin, body)
  )
}

#let layout = vs(
  cuts: (1fr, 2fr, 1fr),
  hs(
    cuts: (1fr, 2fr, 1fr),
    box(<mylabel>), box, box
  ),
  box,
  hs(box, box)
)

#layout


#box-content(margin: (x:10pt))[
= First
#lorem(20)
]
#box-content[
= Second
#lorem(20)
]
#box-content(<mylabel>)[
= Third
#lorem(20)
]
#box-content[
= Fourth
#lorem(20)
]
#box-content[
= Fifth
#lorem(20)
]
#box-content[
= Sixth
#lorem(20)
]
// #box-content(<undef>)[
// = Seventh
// #lorem(20)
// ]

