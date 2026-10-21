// expect-error: poster-columns has 2 children but 3 widths
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], authors: ([A],))
#bmim.poster-columns([a], [b], widths: (1fr, 1fr, 1fr))
