// expect-error: Unknown option 'foo'
#import "/src/lib.typ" as bmim
#show: bmim.letter(location: [H], sender: (name: [S], pos: [P], institute: [I], department: none, tel: [1], fax: none, email: [e], signature: none), recipient: (name: [R], address: [Adr], pro: none, institution: none), foo: 1)
x
