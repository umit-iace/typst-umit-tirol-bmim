// expect-text: Titel des Posters
// expect-text: A. Autor, B. Autorin
// expect-text: Institut für Automatisierungs- und Regelungstechnik
// expect-text: Eine Zugehörigkeit
#import "/src/lib.typ" as bmim
// default: UMIT logo on the right of the header, institute in the footer
#show: bmim.poster(title: [Titel des Posters], authors: ([A. Autor], [B. Autorin]),
  affiliations: [Eine Zugehörigkeit], lang: "de", orientation: "portrait")
