// expect-error: Unknown key 'phone' of 'sender' of letter
#import "/src/lib.typ" as bmim
#show: bmim.letter(location: [H], sender: (name: [S], phone: [1]))
x
