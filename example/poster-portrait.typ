#import "./preamble.typ": *

#show: bmim.poster(
  title: [Control design strategies for better results],
  lang: "en",
  // a poster of a thesis: right in the header the box of the student with
  // photo, name, short bio, type of thesis and supervisors instead of the logo
  thesis: (
    kind: "Master",
    author: [John Doe],
    bio: [Studies of mechatronics at UMIT TIROL, \ focus on control engineering],
    supervisors: ([Jane Doe], [Max Mustermann]),
    photo: rect(width: 100%, height: 7.5em, fill: luma(225), align(center + horizon, text(0.7em, fill: luma(100))[Photo])),
  ),
  page: "a0",
  orientation: "portrait",
  size: 28pt,
  // header-image: default, the mountain panorama
  // footer: default, logo and name of the institute on the right
)

// two boxes in the first row, three in the second, below the angle box
// over the full width with the side on the right and two boxes in its corner
#bmim.poster-rows(
  bmim.poster-columns(poster-boxes.motivation, poster-boxes.approach),
  bmim.poster-columns(poster-boxes.setup, poster-boxes.model, poster-boxes.results),
  poster-angle-box(bmim.poster-rows(poster-boxes.topics, poster-boxes.outlook), at: right),
  heights: (auto, auto, 1fr),
)
