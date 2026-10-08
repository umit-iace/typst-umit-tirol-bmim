// expect-text: umfasst 2 Aufgaben,
// expect-text: Es können insgesamt 5 Punkte erreicht
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exam(course: [K], title: [T], authors: ([A],), total-time: [1h])
= A
#task(points: 2, description: [d], solution: [s])
#task(points: 3, description: [d], solution: [s])
