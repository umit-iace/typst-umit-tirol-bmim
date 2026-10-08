// expect-error: Option 'authors' must be set
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exam(course: [K], title: [T], total-time: [1h])
x
