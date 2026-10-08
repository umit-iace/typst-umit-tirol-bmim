// expect-text: März / March
#import "/src/lib.typ": translated-month
#translated-month(datetime(year: 2026, month: 3, day: 1), "de") / #translated-month(datetime(year: 2026, month: 3, day: 1), "en")
