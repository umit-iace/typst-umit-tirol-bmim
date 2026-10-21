// expect-error: are not allowed for a task with subtasks
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exercise(course: [K], title: [T], authors: ([A],))
#task([P], (points: 1, description: [d], solution: [s]), description: [x])
