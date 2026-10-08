// expect-text: März / March
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#import "/src/lib.typ": translatedMonth, translated-month
#translated-month(datetime(year: 2026, month: 3, day: 1), "de") / #translatedMonth(datetime(year: 2026, month: 3, day: 1), "en")
