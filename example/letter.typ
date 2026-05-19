#import "/src/lib.typ" as bmim

#show: bmim.letter(
  lang: "de",
  recipient-institution: [Maier und Schmidt AG],
  recipient-name: [Joe Mustermann],
  recipient-address: [Auenweg 3\ 6060 Hall in Tirol],
  recipient-pro: [Herrn Dr.],
  sender-department: none,
  sender-institute: [Institut für Automatisierungs- und Regelungstechnik],
  sender-pos: [Universitätsassistent],
  sender-name: [Dipl.-Ing. Max Doe],
  sender-email: "max.doe@umit-tirol.at",
  sender-tel: "+43(0) 50 8648 5678",
  location: "Hall in Tirol",
  sign: none,
  subject: [Schreiben zur Wiederkehr des PID-Reglers],
  date: datetime.today(),
)

Sehr geehrte Damen und Herren,

#v(1em)

#lorem(40)

#lorem(80)

#lorem(20)
