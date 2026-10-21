#import "./poster-preamble.typ": *

#show: bmim.poster(
  title: [Regelungskonzepte für hochtransiente, effizienz- und emissionsoptimierte Großgasmotorenkraftwerke],
  // a poster of a thesis: type, author, supervisors and photo next to the title
  thesis: (
    kind: "Master",
    author: [John Snow],
    supervisors: ([Frank Woittennek], [Simon Bachler]),
    photo: rect(width: 100%, height: 6em, fill: luma(225), align(center + horizon, text(0.7em)[Foto])),
  ),
  page: "a0",
  orientation: "portrait",
  size: 28pt,
  event: [Masterarbeit],
  location: [UMIT TIROL, Hall in Tirol],
  contact: [`john.snow@umit-tirol.at`],
)

// two columns and below them the research box over the full width; `heights`
// lets the columns take the free space instead of the last row
#bmim.poster-rows(
  bmim.poster-columns(
    bmim.poster-rows(boxes.power-plant, boxes.control, boxes.cooling),
    bmim.poster-rows(boxes.cooling-water, boxes.shower, boxes.catalyst, boxes.diagnosis),
  ),
  boxes.research,
  heights: (1fr, auto),
)
