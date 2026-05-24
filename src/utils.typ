#import "data.typ": *
#import "options.typ": *

#let backmatter(content) = {
  set heading(numbering: "A.1")
  counter(heading).update(0)
  state("backmatter").update(true)
  content
}

#let page-is-chap-start() = query(heading.where(level: 1))
  .map(it => it.location().page())
  .contains(here().page())

#let get-page-number(store:"ignore") = {
  let _store = state("pgnum", none)
  if store == "get" {
    _store.get()
  } else {
    let nbr = here().page-numbering()
    let ret = if nbr == none { nbr } else {
      numbering(nbr, ..counter(page).get())
    }
    if store == "push" {
      _store.update( ret )
    } else { //ignore
      ret
    }
  }
}

#let frontmatter(content) = {
  set heading(numbering: none, bookmarked: true, outlined: false)
  set page(numbering: "i")
  content
}
#let mainmatter(content) = context {
  let opts = options.final()
  {
    set page(header: none, numbering: none)
    pagebreak(to: "odd", weak:true)
  }
  set heading(numbering: "1.1", bookmarked: auto, outlined: true)
  show heading.where(level: 1): set heading(supplement: opts.spell.chap)
  set page(numbering: "1")
  counter(page).update(1)
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

#let heading-prefix-numbering(..args, loc: none) = context {
  let hdr = counter(heading).at(
    if loc == none { here() } else { loc }
  )
  let chain = hdr + args.pos()
  return chain.map(str).join(".")
}

#let page-is-chap-start() = {
  return query(heading.where(level: 1))
    .map(it => it.location().page())
    .contains(here().page())
}

#let page-number() = numbering(here().page-numbering(), here().page())

#let is-empty(value) = {
  let empty-values = (
    array: (),
    dictionary: (:),
    str: "",
    content: [],
  )
  let t = repr(type(value))
  if t in empty-values {
    return value == empty-values.at(t)
  } else {
    return value == none
  }
}

#let show-marks(m, ys) = context {
  if m == none { return }
  let y = if type(ys) == array { ys } else { (ys,) }
  let p = m.pages
  if p != "both" and ((p == "odd") != calc.odd(counter(page).get().first())) {
    return
  }
  let l = line(length: m.length, stroke: m.stroke)
  for _y in y { place(top + left, dx: m.xdist, dy: _y, l) }
}
