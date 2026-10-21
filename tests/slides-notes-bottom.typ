// expect-text: Speaker note on the bottom
// expect-text: Slide text
#import "/src/lib.typ" as bmim
#import "@preview/touying:0.8.0": speaker-note
#show: bmim.slides(title: [T], authors: [A], lang: "en", notes: bottom,
  progress-animation: (slides: true, section: true))
#bmim.title-slide()
= Section
== Slide
Slide text
#speaker-note[Speaker note on the bottom]
