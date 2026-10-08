// expect-text: Refs: Aufgabe 1.1 Aufgabe 2.1 Aufgabe 2.2.a
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.workbook(course: [K], authors: ([A],), show-solution: "bottom")
= Vor
#task(points: 1, label: <t1>, description: [d1], solution: [s1])
#show: mainmatter
= Kapitel
#task(points: 2, label: <t2>, description: [d2], solution: [s2])
#task([P], (points: 1, label: <s1>, description: [a], solution: [sa]), (points: 1, description: [b], solution: [sb]))
Refs: @t1 @t2 @s1
