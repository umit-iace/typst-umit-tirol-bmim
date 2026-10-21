// expect-text: Hall in Tirol, 
// expect-text: Masterarbeit
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.thesis(author: [A], university: "UMIT")
= K
Text
