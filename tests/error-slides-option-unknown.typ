// expect-error: Unknown option 'foo'
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [T], authors: [A], foo: 1)
= S
