// expect-error: vCard and iCalendar values must be strings
#import "/src/lib.typ": build-vcard
#build-vcard((lastname: [Doe]))
