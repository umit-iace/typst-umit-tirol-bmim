// expect-text: Slide
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [Title], authors: [A], lang: "en", institute: none)
#bmim.title-slide()
= Section
== Slide
Text.
