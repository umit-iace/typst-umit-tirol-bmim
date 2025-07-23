#import "colors.typ": *

#let months = ("Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember")
#let translatedMonth(dt, lang) = {
  if lang == "de" [
    #months.at(dt.month() - 1)
  ] else [
    #dt.display("[month repr:long]")
  ]
}
