// expect-error: Unknown font 'foo'
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.report(course: [K], title: [T], authors: ([A],), fonts: (foo: "X"))
x
