// expect-text: Wintersemester 2025/2026
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#import "/src/helpers.typ": print-semester
#context print-semester(datetime(year: 2026, month: 2, day: 1))
