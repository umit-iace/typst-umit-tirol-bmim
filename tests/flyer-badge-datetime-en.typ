// expect-text: 5th November 2026, 17:00
#import "/src/lib.typ" as bmim
#import "/src/helpers.typ": print-date-time
// the badge is rotated, its text is extracted in a different order, so the
// format of print-date-time, which the badge uses, is checked in the body
#let date = datetime(year: 2026, month: 11, day: 5, hour: 17, minute: 0, second: 0)
#show: bmim.flyer(title: [T], lang: "en")
#context print-date-time(date)
#bmim.flyer-badge(date)
