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

// two boxes in the first row, three in the second, below the angle box
// over the full width with the side on the right and two boxes in its corner
#bmim.poster-rows(
  bmim.poster-columns(boxes.power-plant, boxes.control),
  bmim.poster-columns(boxes.cooling-water, boxes.shower, boxes.catalyst),
  cooling-angle(bmim.poster-rows(boxes.research, boxes.diagnosis), at: right),
  heights: (auto, auto, 1fr),
)
