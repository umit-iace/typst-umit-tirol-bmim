// expect-error: Option 'lang' must be one of
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.report(course: [K], title: [T], authors: ([A],), lang: "fr")
x
