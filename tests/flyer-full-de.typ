// expect-text: KOLLOQUIUM
// expect-text: Vortragende:
// expect-text: Organisation:
// expect-text: Ort 1
// expect-text: Obere Überschrift
// expect-text: Oben
// expect-text: Kurzbiografie
// expect-text: Bio-Text
// expect-text: Badge-Text
// expect-text: Zweites Logo
#import "/src/lib.typ" as bmim
#show: bmim.flyer(title: [T], series: [Kolloquium], details: (([Vortragende], [P]), ([Organisation], [Ort 1])), qr-code: rect(width: 2em, height: 2em), logo: (flyer-left: [Zweites Logo]))
#bmim.flyer-heading[Obere Überschrift]
Oben
#bmim.flyer-badge[Badge-Text]
#v(1fr)
#bmim.flyer-heading(size: 16pt, rule: 30%)[Kurzbiografie]
Bio-Text
