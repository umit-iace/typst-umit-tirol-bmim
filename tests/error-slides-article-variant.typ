// expect-error: Option 'article-variant' must be one of
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [T], authors: [A], article-mode: true, article-variant: "thesis")
= S
