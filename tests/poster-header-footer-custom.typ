// expect-text: RECHTE-BOX
// expect-text: EIGENER-FUSS
// expect-text: HINTERGRUND
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], authors: ([A],), lang: "de",
  header-right: [RECHTE-BOX], footer: [EIGENER-FUSS], background: place(center + horizon)[HINTERGRUND])
