// expect-text: Doel, Doele, Doeles, et al.
// expect-text: September 30, 2026
// expect-text: very very…
#import "/src/lib.typ" as bmim
#show: bmim.slides(
  title: ([T], "A long short title " + "very " * 50 + "end"),
  authors: [Jane Doe],
  authors-short: [Doel, Doele, Doeles, et al.],
  date: datetime(day: 30, month: 9, year: 2026),
  aspect-ratio: "4-3",
  lang: "en",
)
== Slide
Text.
