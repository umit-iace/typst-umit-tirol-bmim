// expect-text: Slide with own image
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [T], authors: [A], lang: "en",
  header-image: rect(width: 100%, height: 100%, fill: red))
== Slide with own image
Text.
