// expect-text: The subtitle - Short
// expect-text: Control design strategies
// expect-text: 1. Motivation
// expect-text: Prose instead of bullets.
// expect-text: Only in the article.
#import "/src/lib.typ" as bmim
#import "@preview/touying:0.8.0": article-only, article-text, slides-only
#show: bmim.slides(title: ([Control design strategies], [Short]), subtitle: [The subtitle], authors: ([A], [B]), lang: "en", article-mode: true)
#bmim.title-slide()
= Motivation
== Motivation
- Bullet
#article-text[Prose instead of bullets.]
#bmim.outline-slide(title: "Contents")
== Details
Text on the slide.
#article-only[Only in the article.]
#slides-only[Only on the slides.]
