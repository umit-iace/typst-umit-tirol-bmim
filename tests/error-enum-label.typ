// expect-error: Argument 'label' of enum-label must be a string or plain text
#import "/src/lib.typ" as bmim: task, backmatter, mainmatter, enum-label
#enum-label[*fett*]
