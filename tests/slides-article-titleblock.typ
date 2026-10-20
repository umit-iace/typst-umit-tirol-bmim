// expect-text: Own title block: Control design strategies
// expect-text: Text on the slide.
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [Control design strategies], authors: ([A], [B]), lang: "en", article-mode: true,
  titleblock: args => [Own title block: #args.title])
#bmim.title-slide()
= Section
== Details
Text on the slide.
