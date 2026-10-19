// expect-text: First part
// expect-text: Second part
#import "/src/lib.typ" as bmim
#import "@preview/touying:0.8.0": pause
#show: bmim.slides(title: [T], authors: [A], lang: "en", handout: true)
== Slide
First part
#pause
Second part
