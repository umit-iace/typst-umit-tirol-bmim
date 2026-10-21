// expect-error: Subtask 1 of task must be a dictionary
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exercise(course: [K], title: [T], authors: ([A],))
#task([P], [nur Text])
