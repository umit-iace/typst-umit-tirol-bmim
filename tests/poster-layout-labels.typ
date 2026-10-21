// expect-text: Erste Box
// expect-text: Zweite Box
// expect-text: Inhalt B
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], authors: ([A],), lang: "de")
// layout first, the contents follow with labels
#bmim.poster-columns(<a>, bmim.poster-rows(<b>, [frei]))
#bmim.poster-box(<b>)[Zweite Box][Inhalt B]
#bmim.poster-box(<a>)[Erste Box][Inhalt A]
