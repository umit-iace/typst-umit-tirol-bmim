#import "./poster-preamble.typ": *

#show: bmim.poster(
  title: [Regelungskonzepte für hochtransiente, effizienz- und emissionsoptimierte Großgasmotorenkraftwerke],
  authors: (
    [S. Bachler, C. Horngacher & Prof. Dr. F. Woittennek (IACE / UMIT TIROL, Hall in Tirol)],
    [Dr. J. Huber, Dr. H. Kopecek & Dr. K. Spreitzer (GE Power / Jenbach)],
  ),
  page: "a0",
  orientation: "landscape",
  size: 28pt,
  event: [Lange Nacht der Forschung],
  location: [UMIT TIROL, Hall in Tirol],
  contact: [`simon.bachler@umit-tirol.at`],
)

// three columns, the boxes of each column stacked, the last box of each
// column reaches down to the footer
#bmim.poster-columns(
  bmim.poster-rows(boxes.power-plant, boxes.research),
  bmim.poster-rows(boxes.control, boxes.cooling, boxes.cooling-water),
  bmim.poster-rows(boxes.shower, boxes.catalyst, boxes.diagnosis),
)
