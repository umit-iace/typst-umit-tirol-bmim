// expect-text: Statutory Declaration
// expect-text: Master’s Thesis
// expect-text: Co-supervisor:
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#show: bmim.thesis(author: [A], lang: "en", advisor: ((name: [N], university: [U], department: [D], unit: [W]), (name: [N2], university: [U2], department: [D2], unit: [W2])))
= K
Text
