// expect-error: The content of the flyer box is too high for the front page
#import "/src/lib.typ" as bmim

#show: bmim.flyer(title: range(60).map(i => [Sehr langer Titel]).join([ ]))
x
