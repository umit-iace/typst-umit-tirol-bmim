// expect-text: vcard minimal ok
#import "/src/lib.typ": build-vcard
// optional keys are left out
#let v = build-vcard((lastname: "Doe"))
#assert.eq(v, "BEGIN:VCARD\r\nVERSION:3.0\r\nN:Doe;;;;\r\nFN:Doe\r\nEND:VCARD\r\n")
vcard minimal ok
