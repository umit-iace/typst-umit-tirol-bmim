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

// first row three boxes; below the angle box over two columns with the
// cooling water box in its corner, and a column of two boxes on the right;
// the boxes at the bottom reach down to the footer
#bmim.poster-rows(
  bmim.poster-columns(boxes.power-plant, boxes.control, boxes.shower),
  bmim.poster-columns(
    cooling-angle(boxes.cooling-water),
    bmim.poster-rows(boxes.catalyst, boxes.diagnosis),
    widths: (2fr, 1fr),
  ),
  heights: (auto, 1fr),
)
