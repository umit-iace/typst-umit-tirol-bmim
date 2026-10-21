// expect-text: 5th November 2026, 17:00 to 18:30
#import "/src/lib.typ" as bmim
#let start = datetime(year: 2026, month: 11, day: 5, hour: 17, minute: 0, second: 0)
#let end = datetime(year: 2026, month: 11, day: 5, hour: 18, minute: 30, second: 0)
#show: bmim.flyer(title: [T], lang: "en", details: (([Date], [#context bmim.print-date-time(start) to #end.display("[hour]:[minute]")]),))
x
