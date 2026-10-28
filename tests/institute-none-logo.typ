// expect-text: no logo
#import "/src/lib.typ" as bmim
#show: bmim.report(title: [T], authors: ([A],), institute: none)
#bmim.institute-logo(height: 20pt) no logo
