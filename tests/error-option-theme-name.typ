// expect-error: Option 'theme' must be one of
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.report(course: [K], title: [T], authors: ([A],), theme: "cd99")
x
