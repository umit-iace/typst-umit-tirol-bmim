// expect-error: Size 'title' must be a length
#import "/src/lib.typ" as bmim
#show: bmim.flyer(title: [T], sizes: (title: 28))
