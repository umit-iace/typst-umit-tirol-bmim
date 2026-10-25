// expect-text: Inhaltsverzeichnis Abbildungsverzeichnis iii Tabellenverzeichnis v Quellcodeverzeichnis vii Definitionen ix Abkürzungen xi 1 Eins 1 2 Zwei 3
// expect-text: Abbildungsverzeichnis Abb. 1 Bild 1
// expect-text: Tabellenverzeichnis Tab. 1 Tabelle 1
// expect-text: Definitionen Definition 1 Def 1
// expect-text: AC Advanced Control
// two-sided: lists on odd pages, main part with arabic page numbers from 1
// on, chapters on odd pages
#import "/src/lib.typ" as bmim
#show: bmim.lecture(
  course: [K],
  authors: ([A],),
  lists: (image, table, raw, (kind: "def", title: [Definitionen])),
  frontmatter: [
    #heading(numbering: none)[Abkürzungen]
    AC Advanced Control
  ],
)
= Eins
#figure(rect(), caption: [Bild])
#figure(table[x], caption: [Tabelle])
#figure(```c x```, caption: [Code])
#figure(kind: "def", supplement: [Definition], [d], caption: [Def])
= Zwei
