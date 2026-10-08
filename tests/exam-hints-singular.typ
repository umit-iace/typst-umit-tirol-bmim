// expect-text: umfasst 1 Aufgabe,
// expect-text: Es kann insgesamt 1 Punkt erreicht
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exam(course: [K], title: [T], authors: ([A],), total-time: [1h])
= A
#task(points: 1, description: [d], solution: [s])
