// expect-text: all day ok
#import "/src/lib.typ": build-vcalendar
// end, location and description are optional
#let v = build-vcalendar((name: "Day", start: datetime(year: 2026, month: 11, day: 5)))
#let lines = v.split("\r\n")
#assert("DTSTART;VALUE=DATE:20261105" in lines)
#assert(not v.contains("DTEND") and not v.contains("LOCATION") and not v.contains("DESCRIPTION"))
all day ok
