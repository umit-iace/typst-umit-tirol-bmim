// expect-error: Option 'show-solution' must be one of
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.report(course: [K], title: [T], authors: ([A],), show-solution: "oben")
x
