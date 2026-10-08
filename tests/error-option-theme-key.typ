// expect-error: Unknown theme color 'primry'
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.report(course: [K], title: [T], authors: ([A],), theme: (primry: red))
x
