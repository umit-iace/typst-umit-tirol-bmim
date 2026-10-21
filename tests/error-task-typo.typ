// expect-error: Unknown argument(s) of task: descripton
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exercise(course: [K], title: [T], authors: ([A],))
#task(points: 2, descripton: [d], solution: [s])
