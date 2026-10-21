// expect-error: Unknown key 'betreuer' of option 'thesis'
#import "/src/lib.typ" as bmim
#show: bmim.poster(title: [T], thesis: (author: [A], betreuer: [B]))
