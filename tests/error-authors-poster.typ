// expect-error: Option 'authors' must be set
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.poster(title: [T])
x
