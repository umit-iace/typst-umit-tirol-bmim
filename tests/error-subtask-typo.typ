// expect-error: Unknown key 'descripton' of subtask 1
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exercise(course: [K], title: [T], authors: ([A],))
#task([P], (points: 1, descripton: [d], solution: [s]))
