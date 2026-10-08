// expect-error: Key 'name' of build-vcalendar must be set
#import "/src/lib.typ": build-vcalendar
#build-vcalendar((start: datetime(year: 2026, month: 1, day: 1)))
