// expect-text: Winkel
// expect-text: Oben
// expect-text: Seite
// expect-text: Ecke
// expect-text: Rechts
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], authors: ([A],), lang: "de")
#bmim.poster-rows(
  bmim.poster-columns([a], [b], [c]),
  bmim.poster-columns(
    bmim.poster-angle(heading: [Winkel], top: [Oben], side: [Seite], inner: bmim.poster-box[Ecke][x]),
    bmim.poster-angle(heading: [Rechts], top: [o], side: [s], inner: <e>, at: right, widths: (1fr, 2fr)),
    widths: (2fr, 3fr),
  ),
  heights: (auto, 1fr),
)
#bmim.poster-box(<e>)[E][Inhalt]
