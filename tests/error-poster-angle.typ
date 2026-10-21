// expect-error: Option 'at' of poster-angle must be left or right
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], authors: ([A],))
#bmim.poster-angle(heading: [W], inner: [x], at: top)
