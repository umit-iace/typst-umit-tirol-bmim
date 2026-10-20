// expect-text: Exercises for the course
// expect-text: Control design strategies
// expect-text: Text on the slide.
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [Control design strategies], authors: ([A], [B]), lang: "en", article-mode: true,
  article-variant: info => bmim.workbook(course: info.title, authors: info.authors, date: info.date))
#bmim.title-slide()
= Section
== Details
Text on the slide.
