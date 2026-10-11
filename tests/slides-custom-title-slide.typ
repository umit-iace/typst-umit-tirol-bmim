// expect-text: Own title: Control design strategies (Short)
// expect-text: by A and B, 31.12.2024
#import "/src/lib.typ" as bmim
#show: bmim.slides(
  title: ([Control design strategies], [Short]),
  authors: ([A], [B]),
  date: datetime(day: 31, month: 12, year: 2024),
  lang: "en",
  title-slide: info => [
    Own title: #info.title (#info.title-short) \
    by #info.authors.join[ and ], #info.date.display("[day].[month].[year]")
  ],
)
#bmim.title-slide()
== Details
Text on the slide.
