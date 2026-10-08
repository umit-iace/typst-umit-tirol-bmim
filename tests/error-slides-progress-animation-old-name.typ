// expect-error: Unknown option 'progressAnimation'
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [T], authors: [A], progressAnimation: (slides: true))
= S
