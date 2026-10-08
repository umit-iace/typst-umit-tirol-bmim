// expect-error: Unknown key 'streetnumber' of the address of build-vcard
#import "/src/lib.typ": build-vcard
#build-vcard((lastname: "D", address: (streetnumber: "1")))
