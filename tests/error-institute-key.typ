// expect-error: Unknown key 'logos' of option 'institute'
#import "/src/lib.typ" as bmim
#show: bmim.report(title: [T], authors: ([A],), institute: (name: [N], logos: none))
