// expect-error: Option 'institute' must be one of ["iace", "ims"]
#import "/src/lib.typ" as bmim
#show: bmim.report(title: [T], authors: ([A],), institute: "xyz")
