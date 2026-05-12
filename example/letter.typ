#import "/src/lib.typ" as bmim

#show: bmim.letter(
  lang: "de",
  recipient-name: [John Mustermann],
  recipient-address: [Auenweg 3, 6060 Hall in Tirol],
  recipient-pro: [Herr],
  sender-name: [Max Doe],
  sender-pos: [institutsmitarbeiter],
  sender-email: "max.doe@umit-tirol.at",
  sender-tel: "+43(0) 50 8648 5678",
  location: "Hall in Tirol",
  sign: none,
  subject: [*Schreiben zur Wiederkehr des PID-Reglers*],
  date: datetime.today(),
)

Sehr geehrte Damen und Herren,

#v(1em)

#lorem(200)
