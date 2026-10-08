// expect-error: Unknown key 'start_date' of build-vcalendar
#import "/src/lib.typ": build-vcalendar
#build-vcalendar((name: "T", start_date: "20261105"))
