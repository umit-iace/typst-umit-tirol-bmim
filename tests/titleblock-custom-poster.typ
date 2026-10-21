// expect-text: EIGENER-TITEL
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.poster(title: [T], authors: ([A],), titleblock: args => [EIGENER-TITEL])
x
