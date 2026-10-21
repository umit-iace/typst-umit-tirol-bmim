// expect-error: Argument 'color' of umit-logo must be one of
#import "/src/lib.typ" as bmim
#show: bmim.report(title: [T], authors: ([A],))
#bmim.umit-logo(color: "red")
