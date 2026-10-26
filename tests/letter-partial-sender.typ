// expect-text: Mit freundlichen Grüßen
// expect-text: Sabine Muster
#import "/src/lib.typ" as bmim
#show: bmim.letter(location: [H], sender: (name: [Sabine Muster]), recipient: (name: [R]))
x
