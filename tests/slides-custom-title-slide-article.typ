// expect-text: Text on the slide.
#import "/src/lib.typ" as bmim
#show: bmim.slides(
  title: [Control design strategies],
  authors: ([A], [B]),
  lang: "en",
  article-mode: true,
  title-slide: info => [Not in the article],
)
#bmim.title-slide()
== Details
Text on the slide.
