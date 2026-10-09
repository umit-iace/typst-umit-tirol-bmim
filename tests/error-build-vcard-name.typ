// expect-error: Key 'firstname' or 'lastname' of build-vcard must be set
#import "/src/lib.typ": build-vcard
#build-vcard((email: "a@b.c"))
