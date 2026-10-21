// expect-error: Argument 'points' of subtask 1 must be set
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exercise(course: [K], title: [T], authors: ([A],))
#task([P], (description: [d], solution: [s]))
