#import "/src/lib.typ" as bmim: task, enum-label, wrapped-enum-numbering, backmatter, important, tip, example, hint

#show: bmim.thesis(
  program: "Master",
  lang: "en",
  university: "UMIT TIROL",
  title: [
    Steuerung und Regelung \
    von \
    verteilt-parametrischen Systemen
  ],
  author: [John Doe, Bsc],
  date: [October 2025],
  advisor: (
    (
      name: [ Dr. Max Mustermann ],
      university: [
        UMIT TIROL - Private Universität für Gesundheitswissenschaften,
        Medizinische Informatik und Technik
      ],
      department: [
        Department für Biomedizinische Informatik und Mechatronik
      ],
      unit: [ Institut für Automatisierungs- und Regelungstechnik ],
    ),
    (
      name: [ Univ.-Prof. Max Doe ],
      university: [
        UMIT TIROL - Private Universität für Gesundheitswissenschaften,
        Medizinische Informatik und Technik
      ],
      department:[
        Department für Biomedizinische Informatik und Mechatronik
      ],
      unit: [ Institut für Automatisierungs- und Regelungstechnik ],
    ),
  ),
)

#set math.equation(numbering: "(1.1)")

= Kurzfassung

#lorem(40)

= Abstract

#lorem(40)

#show: frontmatter

#show: mainmatter

= Modellierung

#lorem(40)

#show: backmatter

= Appendix

#lorem(40)

#show outline: set heading(outlined:true)
#set heading(numbering: none)

#outline(
  title: [List of Figures],
  target: std.figure.where(kind: image, outlined: true),
)

#outline(
  title:[List of Tables],
  target: std.figure.where(kind: table, outlined: true),
)

#bibliography("sources.bib")
