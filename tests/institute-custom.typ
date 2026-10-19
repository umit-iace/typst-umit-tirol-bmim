// expect-text: Own institute
#import "/src/lib.typ" as bmim
#show: bmim.lecture(course: [Course], authors: ([A],), lang: "en",
  institute: (name: [Own institute], logo: rect(width: 30pt, height: 10pt)))
= Chapter
Text.
