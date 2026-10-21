// expect-error: Option 'theme' must be the name of a theme or a dictionary
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.report(course: [K], title: [T], authors: ([A],), theme: red)
x
