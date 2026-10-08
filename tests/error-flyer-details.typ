// expect-error: Option 'details' must be an array of ([Label], [Text]) pairs
#import "/src/lib.typ" as bmim
#show: bmim.flyer(title: [T], details: ([Presenter], [P]))
x
