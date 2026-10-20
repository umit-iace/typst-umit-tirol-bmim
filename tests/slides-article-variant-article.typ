// expect-text: Control design strategies
// expect-text: Text on the slide.
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: ([Control design strategies], [Short]), subtitle: [The subtitle], authors: ([A], [B]), lang: "en", article-mode: true, article-variant: "article")
#bmim.title-slide()
= Section
== Details
Text on the slide.
