// expect-error: Option 'fonts' must be a dictionary of fonts
#import "/src/lib.typ" as bmim
#show: bmim.report(course: [K], title: [T], authors: ([A],), fonts: "Arial")
x
