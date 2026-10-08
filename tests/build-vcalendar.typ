// expect-text: vcalendar ok
#import "/src/lib.typ": build-vcalendar
#let v = build-vcalendar((
  name: "Talk; about, control",
  location: "UMIT TIROL, Eduard-Wallnöfer-Zentrum 1, 6060 Hall in Tirol",
  start: datetime(year: 2026, month: 11, day: 5, hour: 17, minute: 0, second: 0),
  end: datetime(year: 2026, month: 11, day: 5, hour: 18, minute: 30, second: 0),
  description: "A long description, longer than the 75 octets of a line in iCalendar: ä ö ü.",
))
#let lines = v.split("\r\n")
// no empty line at the beginning, CRLF line endings including the last line
#assert(v.starts-with("BEGIN:VCALENDAR\r\n"))
#assert(v.ends-with("END:VCALENDAR\r\n"))
#assert(not v.replace("\r\n", "").contains("\n"))
// required properties
#assert(lines.any(l => l.starts-with("UID:20261105T170000-talk-about-control@")))
#assert(lines.any(l => l.starts-with("DTSTAMP:") and l.ends-with("T000000Z")))
#assert("SUMMARY:Talk\\; about\\, control" in lines)
#assert("DTSTART:20261105T170000" in lines)
#assert("DTEND:20261105T183000" in lines)
// folded lines: at most 75 octets, unfolding gives the escaped value
#assert(lines.all(l => l.len() <= 75))
#let unfolded = v.replace("\r\n ", "").split("\r\n")
#assert("LOCATION:UMIT TIROL\\, Eduard-Wallnöfer-Zentrum 1\\, 6060 Hall in Tirol" in unfolded)
#assert("DESCRIPTION:A long description\\, longer than the 75 octets of a line in iCalendar: ä ö ü." in unfolded)
vcalendar ok
