// expect-error: No poster-box with label <fehlt> defined
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], authors: ([A],))
#bmim.poster-columns(<fehlt>)
