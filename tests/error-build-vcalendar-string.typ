// expect-error: Key 'start' of build-vcalendar must be a datetime
#import "/src/lib.typ": build-vcalendar
#build-vcalendar((name: "T", start: "20261105"))
