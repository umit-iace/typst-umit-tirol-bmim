// expect-error: Unknown key 'opacity' of option 'header-image'
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [T], authors: [A], header-image: (opacity: 50%))
== S
