#import "/src/lib.typ" as bmim

#show: bmim.letter(
  lang: "de",
  sender-name: [John Mustermann],
  sender-address: [Auenweg 3, 6060 Hall in Tirol],
  sender-pro: [Herr],
  author-name: [Max Doe],
  author-pos: [institutsmitarbeiter],
  author-email: "max.doe@umit-tirol.at",
  author-tel: "+43(0) 50 8648 5678",
  location: "Hall in Tirol",
  sign: none,
  subject: [*Schreiben zur Wiederkehr des PID-Reglers*],
  date: datetime.today(),
)

Sehr geehrte Damen und Herren,

#v(1em)

#lorem(200)
