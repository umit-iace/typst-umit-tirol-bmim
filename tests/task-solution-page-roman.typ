// expect-text: Lösung auf ↪︎ Seite ii.
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#set page(numbering: "i")
#show: bmim.exam(course: [K], title: [T], authors: ([A],), total-time: [1h], show-solution: "bottom")
= Teil
#task(points: 1, description: [d1], solution: [s1])
