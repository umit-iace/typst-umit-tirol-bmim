// expect-error: Option 'orientation' must be one of
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.poster(title: [T], authors: ([A],), orientation: "quer")
x
