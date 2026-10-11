// expect-text: Text on the slide.
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [T], authors: [A], lang: "en", outline-slide: none)
#bmim.outline-slide(title: "Unique outline title")
== Details
Text on the slide.
