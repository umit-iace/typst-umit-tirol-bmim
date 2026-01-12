#import "utils.typ": *
#import "layout.typ": *
#import "list.typ": *
#import "task.typ": task-solutions, task-show-ref, inline

#let item-cnt = counter("item-counter")


#let bmim-common(body) = context {
  let opts = options.final()
  set text(
    lang: opts.lang,
    font: opts.font,
    spacing: .5em,
    size: opts.size,
  )
  set par(leading: 0.55em, spacing: 0.55em, justify: true)
  set page(
    margin: (
      left: 2cm,
      right: 2cm,
      top: 1.9cm,
      bottom: 2.5cm,
    ),
  )
  show raw: set text(font: "CMU Typewriter Text")

  set enum(numbering: "a)")

  show figure.where(kind: table): set figure(supplement: opts.spell.tab)
  show figure.where(kind: table): it => {
    set figure.caption(position: top)
    show figure.caption: smallcaps
    show figure.caption: set align(center)
    it
  }
  show figure.where(kind: image): set figure(supplement: opts.spell.fig)
  show figure.where(kind: image): it => {
    show figure.caption: set align(start)
    it
  }
  set figure(numbering: "1")
  show figure: fig => {
    show figure.caption: cap => context [
      #let n = numbering(cap.numbering, ..cap.counter.at(fig.location()))
      *#cap.supplement~#n*~#sym.minus~#cap.body
    ]
    fig
  }

  show ref: it => {
    let el = it.element
    if el != none and el.func() == metadata and el == enum-label-mark {
      let supp = it.supplement
      if supp == auto {
        supp = opts.spell.item
      }
      // get the counter value in the correct format according to location
      let loc = el.location()
      let num = enum-numbering-state.at(loc)
      if std.type(enum-numbering-state.at(loc)) != str {
        num = enum-numbering-state.at(loc).with(loc:loc)
      }
      let ref-counter = numbering(num, ..enum-counter.at(loc))
      if is-empty(supp) {
        link(el.location(), ref-counter)
      }
      else {
        link(el.location(), box([#supp~#ref-counter]))
      }
    } else {
      it
    }
  }

  show enum: it => {
    if it.start != 0 { return it }
    let args = it.fields()
    let items = args.remove("children")
    context enum(..args, start: item-cnt.get().first() + 1, ..items)
    item-cnt.update(i => i + it.children.len())
  }

  // set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    item-cnt.update(0)
    it
  }

  show heading.where(label: <bmim:nonumber>): set heading(numbering: none, outlined: false)

  // ### Outline
  set outline(depth: 2)
  set outline.entry(fill: repeat[.~])

  show outline.entry.where(level: 1): it => {
    if it.element.func() != heading {
      return it
    }

    set block(above:1em)
    strong(link(
      it.element.location(),
      it.indented(it.prefix(), {it.body(); h(1fr); it.page()}),
    ))
  }

  body
}

#let bmim-exam(
  course: none, // [Course Name] or ([Course Name], [Short Course Name])
  title: none, // str or content
  authors: none, // array of str or content
  date: datetime.today(), // datetime or content
  total-time: none, // str or content
  show-solution: none, // none, inline, bottom
  ..chosen // other options: theme, logo-with-text, size, etc
) = { body => {
  if total-time == none {
    panic("Exam needs total-time option set")
  }
  option-set(
    chosen.named()
    + (show-solution: show-solution)
  )
  show: bmim-common
  show ref: task-show-ref

  set std.page(
    header: (header.exam),
    footer: (footer.exam)(course, title),
  )

  show heading.where(level: 1): heading-colored

  (titleblock.exam)(course, title, authors, date, total-time)

  body

  pagebreak(weak:true)
  task-solutions
}}

#let bmim-exercise(
  course: none, // [Course Name] or ([Course Name], [Short Course Name])
  authors: none, // array of str or content
  date: datetime.today(), // datetime or content
  show-solution: none, // none, inline, bottom
  ..chosen
) = { body => {
}}

#let bmim-lab(
  title: none, // either [Title] , or ([Topic], [Title])
  course: none, // [Course Name] or ([Course Name], [Short Course Name])
  authors: none, // array of str or content
  date: datetime.today(), // datetime or content
  show-solution: inline,
  ..chosen,
) = { body => {
  option-set(
    chosen.named()
    + if "logo-with-text" not in chosen.named() { (logo-with-text: true) }
    + (show-solution: show-solution)
  )
  show: bmim-common
  show ref: task-show-ref

  set std.page(
    header: header.lab,
    footer: (footer.lab)(course, title),
  )

  set heading(numbering: "1.")
  show heading.where(level: 1): heading-colored
  (titleblock.lab)(course, title, authors, date)

  body

  pagebreak(weak:true)
  task-solutions
}}

#let bmim-lecture(
  course: none, // [Course Name] or ([Course Name], [Short Course Name])
  authors: none, // array of str or content
  date: datetime.today(), // datetime or content
  show-solution: none, // none, inline, bottom
  ..chosen
) = { body => {
}}

#let bmim-poster(
  title: none, // str or content
  authors: none, // array of str or content
  page: "a2", // pagesize
  orientation: "landscape", // "landscape", "portrait"
  date: datetime.today(), // datetime or content
  event: none, // str or content
  location: none, // str or content
  contact: none, // str or content
  ..chosen // other options: theme, size, etc
) = { body => {
  option-set(
    chosen.named()
    + if "size" not in chosen.named() { (size: 20pt) }
    + if "logo-with-text" not in chosen.named() { (logo-with-text: true) }
  )
  show: bmim-common

  let margin = (x: 1.5em, y: 4em)
  set std.page(
    paper: page,
    columns: if orientation == "landscape" { 3 } else { 2 },
    flipped: orientation == "landscape",
    margin: margin,
    header: header.poster,
    footer: (footer.poster)(event,date,location,contact),
  )

  set heading(numbering: "1.")

  (titleblock.poster)(title, authors)

  body
}}

#let bmim-report(
  title: none, // str or content
  course: none, // either [Course Name] , or ([Course Name], [Short Course Name])
  authors: none, // array of str or content
  date: datetime.today(), // datetime or content
  ..chosen, // other options: theme, logo-with-text, size, lang, etc
) = { body => context {
  option-set(
    chosen.named()
    + if "logo-with-text" not in chosen.named() { (logo-with-text: true) }
  )
  show: bmim-common
  set heading(numbering: none)
  set text(spacing: 100%)
  set page(
    columns: 2,
    header: header.report,
    footer: (footer.report)(course, title),
  )

  show heading.where(level: 2): set text(weight: "light", size: options.final().size)
  show heading.where(level: 2): emph

  (titleblock.report)(course, title, authors, date)

  body
}}

#let bmim-workbook(
  course: none,
  authors: none,
  date: datetime.today(),
  ..chosen,
) = { body => {
  option-set(
    chosen.named()
    + if "logo-with-text" not in chosen.named() { (logo-with-text: true) }
  )
  show: bmim-common
  show ref: task-show-ref

  (titleblock.workbook)(course, authors, date)

  set page(
    header: header.workbook,
    footer: (footer.workbook)(),
    numbering: "1",
  )

  let headings-on-odd-page(it) = {
		show heading.where(level: 1): it => {
			{
				set page(header: none, footer: none, numbering: none)
				pagebreak(to: "odd")
			}
			it
		}
		it
	}
  set heading(numbering: "1.1")
  show heading.where(level:2): heading-colored
  show heading.where(level:1): it => context {
    set block(inset: (y: 5em))
    show: strong
    show: block
    if it.numbering == none { it.body; return }
    let n(..c) = numbering(it.numbering, ..c)
    [

      #set text(1.3em)
      Kapitel #n(..counter(heading).get())
      #v(2em)
      #set text(1.5em)
      #it.body
    ]
  }
	show: headings-on-odd-page

  outline()


  body
}}
