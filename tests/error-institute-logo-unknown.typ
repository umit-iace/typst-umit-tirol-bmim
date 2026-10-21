// expect-error: Argument 'institute' of institute-logo must be one of
#import "/src/lib.typ" as bmim
#show: bmim.report(title: [T], authors: ([A],))
#bmim.institute-logo(institute: "xyz")
