// expect-text: Wintersemester 2026/2027
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#import "/src/helpers.typ": print-semester
#context print-semester(datetime(year: 2026, month: 10, day: 1))
