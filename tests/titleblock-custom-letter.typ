// expect-text: EIGENER-TITEL
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.letter(location: [H], sender: (name: [S], pos: [P], institute: [I], department: none, tel: [1], fax: none, email: [e], signature: none), recipient: (name: [R], address: [Adr], pro: none, institution: none), titleblock: args => [EIGENER-TITEL])
x
