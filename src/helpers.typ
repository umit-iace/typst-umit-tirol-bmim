#import "data.typ": *
#import "options.typ": *

#let abstract(body) = context {
  // abstract environment for the article class
  let opts = options.final()
  set par(leading: .5em)
  set text(font: opts.fonts.sans, spacing: 80%, size: 1.1em)
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

#let chapter-break(oneside, to: "odd") = if oneside {
  pagebreak(weak: true)
} else {
  pagebreak(to: to, weak: true)
}

// Heading rules shared by book-like variants (lecture, thesis): reduce the
// spacing between consecutive headings and scale the levels 2 to 5.
#let book-headings(spacing-after: 0.2em, body) = {
  show heading: it => {
    // Clever trick to reduce spacing between consecutive headings
    // See https://github.com/typst/typst/issues/2953
    let previous_headings = query(selector(heading).before(here(),
      inclusive: false))
    if previous_headings.len() > 0 {
      let prev_loc = previous_headings.last().location().position()
      let it_loc = it.location().position()
      if (it_loc.page == prev_loc.page
        and it_loc.x == prev_loc.x
        and it_loc.y - prev_loc.y < 60pt) { // threshold
        // amount to reduce spacing, could make this dependent on it.level
        v(-0.3em)
      }
    }
    [#it #v(spacing-after)]
  }
  show heading.where(level:2): set text(size: 1.4em)
  show heading.where(level:3): set text(size: 1.2em)
  show heading.where(level:4): set text(size: 1.1em)
  show heading.where(level:5): it => text(
    weight: 700,
    it.body) + [.]
  body
}

#let chapter-heading(inset: 2em, weight: auto, style) = it => context {
  if query(<appendix>).any(e => e == it) { return }
  set text(weight: weight) if weight != auto
  set block(inset: (y: inset))
  show: strong
  show: block
  if it.numbering == none { it.body; return }
  style(it, numbering(it.numbering, ..counter(heading).get()))
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

// Set to true from the start of the backmatter (appendix) on
#let backmatter-state = state("bmim-backmatter", none)

#let backmatter(content, to: "odd") = context {
  let opts = options.final()
  set heading(numbering: "A.1", supplement: opts.spell.appendix)
  counter(heading).update(0)
  backmatter-state.update(true)
  {
    show heading: none
    chapter-break(opts.oneside, to: to)
    [#heading(numbering: none)[#opts.spell.appendix] <appendix>]
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

