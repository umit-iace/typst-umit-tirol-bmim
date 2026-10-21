// expect-text: Sommersemester 2026
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#import "/src/helpers.typ": print-semester
#context print-semester(datetime(year: 2026, month: 4, day: 1))
