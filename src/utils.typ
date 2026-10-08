#import "data.typ": *
#import "options.typ": *

#let abstract(body) = context {
  // abstract environment for the article class
  let opts = options.final()
  set par(leading: .5em)
  set text(font: "Source Sans 3", spacing: 80%, size: 1.1em)
  text(weight: "semibold", fill: opts.theme.primary)[#opts.spell.abstract.]
  text(style: "normal")[#body]
}

#let page-is-chap-start() = {
  return query(heading.where(level: 1))
    .map(it => it.location().page())
    .contains(here().page())
}

#let long(x) = if type(x) == array { x.at(0) } else { x }
#let short(x) = if type(x) == array { x.at(1) } else { x }

#let chapter-break(oneside) = if oneside {
  pagebreak(weak: true)
} else {
  pagebreak(to: "odd", weak: true)
}

#let pick-logo(logo, key) = if type(logo) == dictionary {
  logo.at(key, default: auto)
} else {
  logo
}

#let headings-on-odd-page(it) = {
  show heading.where(level: 1): it => {
    pagebreak(to: "odd")
    it
  }
  it
}

#let headings-on-next-page(it) = {
  show heading.where(level: 1): it => {
    pagebreak()
    it
  }
  it
}

#let mainmatter(content) = context {
  let opts = options.final()

  show: if opts.oneside {headings-on-next-page } else { headings-on-odd-page }

  set page(numbering: "1")
  counter(page).update(1)

  content
}

#let backmatter(content, to: "odd") = context {
  let opts = options.final()
  set heading(numbering: "A.1", supplement: opts.spell.appendix)
  counter(heading).update(0)
  state("backmatter").update(true)
  {
    show heading: none
    [
      #if opts.oneside [
        #pagebreak(weak: true)
      ] else [
        #pagebreak(to: to, weak: true)
      ]
      #heading(numbering: none)[#opts.spell.appendix] <appendix>
    ]
  }
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
  } else if opts.lang == "de" {
    [#date.day(). #translatedMonth(date, opts.lang) #date.year()]
  } else {
    [#translatedMonth(date, opts.lang) #date.day(), #date.year()]
  }
}

#let print-semester(date) = {
  let opts = options.final()
  if type(date) != datetime {
    none
  } else if date.month() > 3 and date.month() < 10 {
    [#opts.spell.summer-term #date.year()]
  } else {
    let start = if date.month() <= 3 { date.year() - 1 } else { date.year() }
    [#opts.spell.winter-term #start/#(start + 1)]
  }
}

#let heading-prefix-numbering(..args, loc: none) = context {
  let hdr = counter(heading).at(
    if loc == none { here() } else { loc }
  )
  let chain = hdr + args.pos()
  return chain.map(str).join(".")
}

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

