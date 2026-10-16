// expect-text: lang de, size 18pt, Source Code Pro
// expect-text: Inhalt
#import "/src/lib.typ" as bmim
#import "@preview/touying:0.8.0": touying-slide-wrapper, touying-slide
#show: bmim.slides(
  title: [T],
  authors: [A],
  lang: "de",
  title-slide: (..args) => touying-slide-wrapper(self => {
    let opts = self.info.extra.opts
    touying-slide(self: self)[lang #opts.lang, size #opts.size, #opts.fonts.mono]
  }),
  outline-slide: (cover-lvl: 1) => touying-slide-wrapper(self => touying-slide(self: self,
    if self.info.extra.opts.lang == "de" [Inhalt] else [Contents])),
)
#bmim.title-slide()
#bmim.outline-slide()
== Folie
Text.
