// expect-text: Contents List of Figures iii 1 Section
// expect-text: List of Figures Fig. 1 A figure 1
// the lists of the lecture variant also work in the article mode of the
// slides, where `#show: mainmatter` and `set page` in the content cannot be used
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [T], authors: ([A],), lang: "en", article-mode: true, article-variant: "lecture", lists: (image,))
#bmim.title-slide()
= Section
== Details
#figure(rect(), caption: [A figure])
