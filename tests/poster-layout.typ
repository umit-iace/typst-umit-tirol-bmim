// expect-text: Box oben
// expect-text: Box unten
// expect-text: Spalte
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], authors: ([A],), page: "a3", orientation: "portrait")
#bmim.poster-rows(
  bmim.poster-columns(bmim.poster-box[Box oben][x], bmim.poster-box[Spalte][y], widths: (2fr, 1fr)),
  bmim.poster-box[Box unten][z],
  heights: (1fr, auto),
)
