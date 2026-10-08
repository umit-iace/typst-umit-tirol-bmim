// expect-text: KOLLOQUIUM
// expect-text: Vortragende:
// expect-text: Organisation:
// expect-text: Ort 1
// expect-text: Kurzbiografie
// expect-text: Bio-Text
// expect-text: Badge-Text
// expect-text: Zweites Logo
#import "/src/lib.typ" as bmim
#show: bmim.flyer(title: [T], series: [Kolloquium], details: (([Vortragende], [P]), ([Organisation], [Ort 1])), qr-code: rect(width: 2em, height: 2em), badge: [Badge-Text], back-bottom-title: [Kurzbiografie], back-bottom-rule: 30%, back-bottom: [Bio-Text], logo: (flyer-left: [Zweites Logo]))
Oben
