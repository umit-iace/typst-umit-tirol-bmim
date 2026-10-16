// expect-text: Presenter:
// expect-text: Free row without label
// expect-text: Another free row
#import "/src/lib.typ" as bmim
#show: bmim.flyer(
  title: [T],
  lang: "en",
  details: (
    ([Presenter], [Jane Doe]),
    (none, [Free row without label]),
    ([], [Another free row]),
  ),
)
