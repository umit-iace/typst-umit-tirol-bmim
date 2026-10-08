// expect-text: vcard ok
#import "/src/lib.typ": build-vcard
#let v = build-vcard((
  title: "Dr.-Ing.", firstname: "Jane", lastname: "Doe", role: "Postdoc",
  organization: "UMIT TIROL", telephone: "+43 1", email: "jane@example.org",
  url: "https://example.org",
  address: (street: "Gain Street 1", zip: "1234", town: "Hall, Tirol", country: "Austria"),
))
#let lines = v.split("\r\n")
#assert(v.starts-with("BEGIN:VCARD\r\nVERSION:3.0\r\n"))
#assert(v.ends-with("END:VCARD\r\n"))
#assert("N:Doe;Jane;;Dr.-Ing.;" in lines)
#assert("FN:Dr.-Ing. Jane Doe" in lines)
#assert("TITLE:Postdoc" in lines)
#assert("ORG:UMIT TIROL" in lines)
// the comma in the town is escaped
#assert("ADR;TYPE=WORK:;;Gain Street 1;Hall\\, Tirol;;1234;Austria" in lines)
#assert("TEL;TYPE=WORK:+43 1" in lines)
#assert("EMAIL;TYPE=INTERNET:jane@example.org" in lines)
vcard ok
