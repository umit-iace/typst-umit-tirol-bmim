// expect-error: Key 'width' of option 'header-image' must be greater than 0%
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [T], authors: [A], header-image: (width: 0%))
