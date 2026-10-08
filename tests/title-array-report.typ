// expect-text: Langer Titel
// expect-text: K - Kurz
#import "/src/lib.typ" as bmim
#show: bmim.report(course: [K], title: ([Langer Titel], [Kurz]), authors: ([A],))
= Abschnitt
Text
