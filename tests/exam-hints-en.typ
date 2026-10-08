// expect-text: consists of 1 task,
// expect-text: A total of 1 point can be achieved
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.exam(course: [K], title: [T], authors: ([A],), total-time: [1h], lang: "en")
= A
#task(points: 1, description: [d], solution: [s])
