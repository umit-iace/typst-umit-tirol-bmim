// expect-text: Logos
#import "/src/lib.typ" as bmim
#show: bmim.report(title: [T], authors: ([A],), lang: "en", institute: "ims")
Logos
#bmim.umit-logo(height: 20pt)
#bmim.umit-logo(color: "blue", subtitle: false, height: 20pt)
#bmim.institute-logo(height: 20pt)
#bmim.institute-logo(institute: "iace", height: 20pt)
