// expect-error: task with 'points' takes no positional arguments
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exercise(course: [K], title: [T], authors: ([A],))
#task([P], points: 2, description: [d], solution: [s])
