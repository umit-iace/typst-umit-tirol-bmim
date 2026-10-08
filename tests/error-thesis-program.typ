// expect-error: Option 'program' must be one of
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.thesis(author: [A], program: "PhD")
x
