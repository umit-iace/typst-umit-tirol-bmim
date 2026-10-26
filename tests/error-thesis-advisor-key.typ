// expect-error: Unknown key 'title' of 'advisor' of thesis
#import "/src/lib.typ" as bmim
#show: bmim.thesis(author: [A], advisor: (name: [Prof. X], title: [Dr.]))
= K
