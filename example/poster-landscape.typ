#import "./preamble.typ": *

#show: bmim.poster(
  title: [Control design strategies for better results],
  lang: "en",
  authors: ([Jane Doe#super[1]], [John Doe#super[2]], [Max Mustermann#super[1]]),
  affiliations: (
    [#super[1]Institute of Automation and Control Engineering, UMIT TIROL, Hall in Tirol, Austria],
    [#super[2]Department of Mechatronics, University of Innsbruck, Innsbruck, Austria],
  ),
  page: "a0",
  orientation: "landscape",
  size: 28pt,
  // boxes in the design of poster-ecklebe: gray headings with a golden line,
  // no frame; "framed" (default) with heading bar and frame
  box-style: "plain",
  // own titleblock in the left box of the header: title, authors and
  // affiliations centered, without the golden line, sized to fit the lower
  // header of the landscape poster
  titleblock: args => {
    set align(center)
    set text(fill: white)
    set par(justify: false, leading: 0.4em)
    block(below: 1em, text(2.2em, weight: "bold", args.title))
    block(below: 0.5em, text(1.1em, args.authors.join(", ")))
    text(0.75em, args.affiliations.join(linebreak()))
  },
  // section of the mountain panorama behind the header and a stronger
  // overlay; false switches it off, an own image is shown as given, e.g.
  // image("header.jpg", width: 100%, height: 100%, fit: "cover")
  header-image: (x: 60%, y: 55%, width: 80%, overlay: 85%),
  // own footer: event and contact on the left, the institute on the right
  footer: grid(
    columns: (1fr, auto),
    align: horizon,
    [*94th Conference of Applied Mathematics*, Somewhere \ `jane.doe@umit-tirol.at`],
    bmim.institute-logo(height: 2.2em),
  ),
)

// first row three boxes; below the angle box over two columns with a box in
// its corner, and a column of two boxes on the right;
// the boxes at the bottom reach down to the footer
#bmim.poster-rows(
  bmim.poster-columns(poster-boxes.motivation, poster-boxes.approach, poster-boxes.model),
  bmim.poster-columns(
    poster-angle-box(poster-boxes.setup),
    bmim.poster-rows(poster-boxes.results, poster-boxes.outlook),
    widths: (2fr, 1fr),
  ),
  heights: (auto, 1fr),
)
