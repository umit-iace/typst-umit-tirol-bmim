// expect-error: Argument 'description' of task must be set
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exercise(course: [K], title: [T], authors: ([A],))
#task(points: 2, solution: [s])
