// expect-text: Dr. A, Uni B, Dep C, Unit D
#import "/src/lib.typ" as bmim
#show: bmim.thesis(author: [A], advisor: (name: [ Dr. A ], university: [ Uni B ], department: [ Dep C ], unit: [ Unit D ]))
= K
Text
