// expect-text: 5th November 2026, 17:00–18:30
// expect-text: 5th November 2026, 17:00 – 6th November 2026, 10:00
// expect-text: 5th November 2026 – 7th November 2026
#import "/src/lib.typ" as bmim
#import "/src/helpers.typ": print-date-time
// the badge is rotated, its text is extracted in a different order, so the
// format of print-date-time, which the badge uses, is checked in the body
#let start = datetime(year: 2026, month: 11, day: 5, hour: 17, minute: 0, second: 0)
#show: bmim.flyer(title: [T], lang: "en")
#context print-date-time(start, end: datetime(year: 2026, month: 11, day: 5, hour: 18, minute: 30, second: 0))

#context print-date-time(start, end: datetime(year: 2026, month: 11, day: 6, hour: 10, minute: 0, second: 0))

#context print-date-time(datetime(year: 2026, month: 11, day: 5), end: datetime(year: 2026, month: 11, day: 7))
#bmim.flyer-badge(start, end: datetime(year: 2026, month: 11, day: 5, hour: 18, minute: 30, second: 0))
