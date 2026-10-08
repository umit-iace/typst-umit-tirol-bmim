#import "./preamble.typ": *
#import "@preview/rustycure:0.2.0": qr-code

#show: bmim.poster(
  title:[],
  authors:(
    [John Doe & Jane Doe],
    [Max Mustermann]
  ),
  contact: [`iace.office@umit-tirol.at`],
  event: [Wichtiges Event],
  location: [UMIT TIROL, Hall in Tirol],
)

#poster-box[A Box][
  #lorem(30)
]

#poster-box(height:1fr)[Another Box][
  Do try @tab:try.
  #figure(
    table(
      columns: 4,
      ..(context{counter("a").step(); str(counter("a").get().first())},)*8,
    ),
    caption: [Try me! #lorem(20)],
  ) <tab:try>
]
#colbreak()

#poster-box[QR Code Examples][
  == A Hyperlink
  #qr-code(
      width: 5cm,
      dark-color: bmim.color-cd2020.dark_gray,
      light-color: bmim.color-cd2020.light_gray,
      "https://github.com/umit-tirol/",
  )

  == A Mecard
  #let contact = (
        title: "Dr.-Ing.",
        firstname: "Feedback",
        lastname: "Control",
        role: "Postdoc",
        address: (
            streetnumber: "Gain Street 1",
            zip: "1234",
            town: "Stable Valley",
            country: "Pole Islands",
        ),
        telephone: "+123456789",
        email: "feddback@contr.ol",
    )
  #qr-code(
      height: 5cm,
      quiet-zone: false,
      dark-color: white,
      light-color: bmim.color.blue,
      bmim.build_mecard(contact),
  )

  == A VCalender (ics)
  #let event = (
        name: "Big Event",
        location: "Big Venue",
        start_date: "20261010", //YYYYMMDD
        start_time: "123400", //HHMMSS
        end_date: "20261012",
        end_time: "234500",
        description: "Very big event"
    )
  #qr-code(
      height: 5cm,
      quiet-zone: false,
      dark-color: white,
      light-color: bmim.color.blue,
      bmim.build_vcalender(event),
  )
]
