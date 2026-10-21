// expect-text: Masterarbeit
// expect-text: Bearbeiter
// expect-text: Betreuer
// expect-text: Frank Woittennek
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], lang: "de", thesis: (author: [John Snow], supervisors: ([Frank Woittennek], [Simon Bachler])))
