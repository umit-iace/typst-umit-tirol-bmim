// expect-text: Sized title
// expect-text: Sized heading
#import "/src/lib.typ" as bmim
#show: bmim.flyer(
  title: [Sized title],
  series: [Series],
  details: (([Date], [Today]),),
  size: 12pt,
  sizes: (series: 10pt, title: 30pt, details: 12pt, badge: 14pt, heading: 24pt),
)
#bmim.flyer-heading[Sized heading]
#bmim.flyer-badge[Badge]
Body text.
