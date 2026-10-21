// expect-text: Masterarbeit
// expect-text: John Snow
// expect-text: Kurzbio des Studenten
// expect-text: Betreuer
// expect-text: Frank Woittennek
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], lang: "de", thesis: (author: [John Snow], bio: [Kurzbio des Studenten], supervisors: ([Frank Woittennek], [Simon Bachler])))
