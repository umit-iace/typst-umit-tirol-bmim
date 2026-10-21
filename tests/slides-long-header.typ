// expect-text: very very…
// expect-text: Short header
// expect-text: 1.1 Numbered
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [T], authors: [A], lang: "en")
== This is a very very very very very very very very very very very very very very very very very long slide head
Text.
== Math $x^2 + y^2 = z^2$ in a very very very very very very very very very very very long slide head
Text.
== Short header
Text.
#set heading(numbering: "1.1")
= Section
== Numbered
Text.
