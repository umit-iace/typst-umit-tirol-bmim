// expect-error: Key 'overlay' of option 'header-image' must be a ratio between 0% and 100%, but was set to 150%
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [T], authors: [A], header-image: (overlay: 150%))
