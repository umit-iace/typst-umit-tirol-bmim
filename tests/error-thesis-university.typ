// expect-error: Option 'university' must be one of
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.thesis(author: [A], university: "TUM")
x
