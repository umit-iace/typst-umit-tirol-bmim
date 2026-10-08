// expect-text: Date: March 1, 2026
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.article(title: [T], authors: ([A],), lang: "en", date: datetime(year: 2026, month: 3, day: 1))
x
