// expect-error: Option 'total-time' must be set
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exam(course: [K], title: [T], authors: ([A],))
x
