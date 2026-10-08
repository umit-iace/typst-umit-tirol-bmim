// expect-text: Aufgabe 1
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exercise(course: [K], title: [T], authors: ([A],))
#counter("task").update(5)
#task(points: 2, description: [d], solution: [s])
