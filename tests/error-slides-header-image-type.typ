// expect-error: Key 'y' of option 'header-image' must be a ratio between 0% and 100%
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [T], authors: [A], header-image: (y: 10pt))
