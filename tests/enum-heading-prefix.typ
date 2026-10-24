// expect-text: 1.1.1 Step 1.1.2 Nested 1.1.2.1 Sub
// expect-text: 2.1 Depth
// expect-text: See Element 1.1.2 and Element 1.1.2.1
#import "/src/lib.typ" as bmim: enum-label, wrapped-enum-numbering, heading-prefix-numbering
#show: bmim.article(title: [T], authors: ([A],))
#set heading(numbering: "1.1")

= One
== Sub
#set enum(full: true, numbering: wrapped-enum-numbering(heading-prefix-numbering))
+ Step
+ #enum-label("nested")Nested
  + #enum-label("sub")Sub

= Two
// the reference uses the prefix of the item, not of this section
See @nested and @sub

#set enum(numbering: wrapped-enum-numbering(heading-prefix-numbering.with(depth: 1)))
+ Depth
