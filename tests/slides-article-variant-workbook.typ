// expect-text: Exercises for the course
// expect-text: Contents List of Figures iii 1 Section
// expect-text: Text on the slide.
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: ([Control design strategies], [Short]), authors: ([A], [B]), lang: "en", article-mode: true, article-variant: "workbook", lists: (image,))
#bmim.title-slide()
= Section
== Details
Text on the slide.
#figure(rect(), caption: [A figure])
