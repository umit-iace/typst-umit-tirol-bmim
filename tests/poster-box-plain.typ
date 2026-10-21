// expect-text: Erste Box
// expect-text: Winkel
// expect-text: Inhalt
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], authors: ([A],), box-style: "plain")
#bmim.poster-columns(
  bmim.poster-box[Erste Box][Inhalt],
  bmim.poster-angle(heading: [Winkel], top: [o], side: [s], inner: bmim.poster-box[Ecke][x]),
)
