#import "@preview/touying:0.6.3": *
#import "colors.typ": *
#import "data.typ": *
#import "utils.typ": translatedMonth
#import "options.typ": options

#let title-slide(
  ..args) = touying-slide-wrapper(self => {
  let opts = options.final()
  let new-config = utils.merge-dicts(
    opts,
    config-page(
      footer: none,
      margin: (top: 4em, left: 1em),
    ),
    config-common(freeze-slide-counter:true),
  )

  self = utils.merge-dicts(self, new-config)

  let authors = (self.info.authors,).flatten()
  let title = (self.info.title,).flatten()
  let subtitle = self.info.subtitle
  let institution = self.info.institution
  let conference = self.info.conference
  let date = self.info.date

  let bold(size, body) = text(size: size, fill:self.colors.primary, weight: "bold", body)

  let body = {
    set align(center + horizon)
    block(
      fill: self.colors.background,
      inset: 1.5em,
      radius: 0.5em,
      breakable: false,
      {
        bold(1.4em, title.at(0, default:none))
        if subtitle != none {
          parbreak()
          bold(1.0em, subtitle)
        }
      },
    )
    // authors
    grid(
      columns: (1fr,) * calc.min(authors.len(), 3),
      column-gutter: 1em,
      row-gutter: 1em,
      ..authors.map(author => text(fill: black, author)),
    )
    v(0.5em)
    // institution
    if institution != none {
      parbreak()
      bold(0.7em, institution)
    }
    // conference
    if conference != none {
      parbreak()
      text(size: 1.0em, conference)
      linebreak()
    }
    // date
    if date != none {
      if conference == none {
        parbreak()
      }
      text(size: 1.0em,
        if opts.lang == "de" {
          [#date.day(). #translatedMonth(date, opts.lang) #date.year()]
        } else {
          [#translatedMonth(date, opts.lang) #date.day(), #date.year()]
        }
      )
    }
  }

  touying-slide(self: self, body)
})

#let outline-slide(
  ..args) = touying-slide-wrapper(self => {
  let opts = options.final()
  let new-config = utils.merge-dicts(
    opts,
    config-page(
      margin: (top: 2em, left: 1em),
    ),
  )

  self = utils.merge-dicts(self, new-config)

  let cntOutline = counter("outline")

  let body = {
    show: align.with(horizon)

    show outline.entry.where(level: 1): it => {
      cntOutline.step()

      link(it.element.location(), grid(
        columns: (auto, auto, auto),
        gutter: 10pt,
        block(
          fill: self.colors.primary,
          inset: 4pt,
          strong(context text(
            fill: white,
            cntOutline.display()),
          ),
        ),
        strong(it.indented(it.prefix(), it.body()))))
    }

    components.adaptive-columns(
      start: text(
        1.2em,
        fill: self.colors.primary,
        weight: "bold",
        utils.call-or-display(self, none),
      ),
      text(
        fill: self.colors.primary,
        outline(title: none, indent: 1em, depth: 1, ..args),
      ),
    )
    show: pad.with(x: 1.6em)
  }

  touying-slide(self: self, body)
})

#let new-section-slide(
  level: 1,
  numbered: true,
  ..args) = touying-slide-wrapper(self => {
  let opts = options.final()
  let new-config = utils.merge-dicts(
    opts,
    config-page(
      margin: (top: 4em, left: 1em),
    ),
  )

  self = utils.merge-dicts(self, new-config)
  self.store.title = ""

  let body = {
    show: align.with(center + horizon)
    show: pad.with(20%)
    set text(size: 1.5em, fill: self.colors.neutral-lightest, weight: "bold")
    stack(
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        components.progress-bar(height: 2pt, self.colors.primary, self.colors.primary-light),
      ),
      v(0.5em),
      block(
        fill: self.colors.neutral-light,
        radius: 8pt,
        move(dx: -4pt, dy: -4pt, block(
          width: 100%,
          fill: self.colors.primary,
          inset: (x: 1em, y: .8em),
          radius: 8pt,
          utils.display-current-heading(level: level, numbered: numbered)
        ))
      ),
    )
  }

  touying-slide(self: self, body)
})
