// expect-text: Own title: Control design strategies (arg)
// expect-text: by A and B
#import "/src/lib.typ" as bmim
#import "@preview/touying:0.8.0": touying-slide-wrapper, touying-slide
#show: bmim.slides(
  title: ([Control design strategies], [Short]),
  authors: ([A], [B]),
  lang: "en",
  title-slide: (extra: none) => touying-slide-wrapper(self => touying-slide(self: self, [
    Own title: #self.info.title.first() (#extra) \
    by #self.info.authors.join[ and ]
  ])),
)
#bmim.title-slide(extra: [arg])
== Details
Text on the slide.
