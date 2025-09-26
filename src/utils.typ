#import "data.typ": *
#import "options.typ": *

#let backmatter(content) = {
  set heading(numbering: "A.1")
  counter(heading).update(0)
  state("backmatter").update(true)
  content
}

#let translatedMonth(dt, lang) = {
  if lang == "de" {
    months.at(dt.month() - 1)
  } else {
    dt.display("[month repr:long]")
  }
}

#let print-date(date) = {
  let opts = options.final()
  if type(date) != datetime {
    date
  } else [#date.day(). #translatedMonth(date, opts.lang) #date.year()]
}


#let heading_prefix_numbering(..args, loc: none) = context {
  let hdr = counter(heading).at(
    if loc == none { here() } else { loc }
  )
  let chain = hdr + args.pos()
  return chain.map(str).join(".")
}

