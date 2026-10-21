// expect-error: Option 'box-style' must be one of ["framed", "plain"]
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], authors: ([A],), box-style: "rahmen")
