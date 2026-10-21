// expect-text: Own outline: Contents (cover 2)
#import "/src/lib.typ" as bmim
#import "@preview/touying:0.8.0": touying-slide-wrapper, touying-slide
#show: bmim.slides(
  title: [T],
  authors: [A],
  lang: "en",
  outline-slide: (cover-lvl: 1, title: none) => touying-slide-wrapper(self => touying-slide(self: self, [
    Own outline: #title (cover #cover-lvl)
  ])),
)
#bmim.outline-slide(title: "Contents", cover-lvl: 2)
= Section
== Details
Text on the slide.
