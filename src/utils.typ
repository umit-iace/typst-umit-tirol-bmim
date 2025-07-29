#import "colors.typ": *

#let backmatter(content) = {
  set heading(numbering: "A.1")
  counter(heading).update(0)
  state("backmatter").update(true)
  content
}

#let dictSpell = (
  "en": (
    "ho": "handed out",
    "lc": "last changed",
    "sol": "solution",
    "fig": "Fig.",
    "tab": "Tab.",
    "with": "with",
    "on": "on",
    "poi": "Points",
    "mark": "Mark",
    "eval": "Evaluation",
    "item": "Item",
  ),
  "de": (
    "ho": "ausgegeben von",
    "lc": "zuletzt geändert",
    "sol": "Lösung",
    "fig": "Abb.",
    "tab": "Tab.",
    "with": "mit",
    "on": "am",
    "poi": "Punkte",
    "mark": "Note",
    "eval": "Bewertung",
    "item": "Element",
  )
)

#let months = ("Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember")
#let translatedMonth(dt, lang) = {
  if lang == "de" [
    #months.at(dt.month() - 1)
  ] else [
    #dt.display("[month repr:long]")
  ]
}

#let heading_prefix_numbering(..args, loc: none) = context {
  let hdr = counter(heading).at(
    if loc == none { here() } else { loc }
  )
  let chain = hdr + args.pos()
  return chain.map(str).join(".")
}

