#import "@preview/touying:0.6.3": *
#import "colors.typ": *
#import "data.typ": *
#import "utils.typ": translatedMonth
#import "options.typ": options

#let title-slide(
  ..args,
) = touying-slide-wrapper(self => {
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
  let mainAuthorIdx = self.info.mainAuthorIdx
  let title = (self.info.title,).flatten()
  let subtitle = self.info.subtitle
  let institution = self.info.institution
  let conference = self.info.conference
  let location = self.info.location
  let date = self.info.date

  let bold(size, body) = text(size: size, fill:self.colors.primary, weight: "bold", body)

  let body = {
    set align(center + horizon)
    v(-3.0em)
    block(
      fill: self.colors.background,
      inset: 1.5em,
      radius: 0.5em,
      breakable: false,
      {
        bold(1.75em, title.at(0, default:none))
        if subtitle != none {
          parbreak()
          bold(1.0em, subtitle)
        }
      },
    )
    v(0.5em)
    // authors
    grid(
      columns: (1fr,) * calc.min(authors.len(), 3),
      column-gutter: 1em,
      row-gutter: 1em,
        ..authors.enumerate().map(((idx, author)) => {
          author + if mainAuthorIdx == idx [$zwj^star$]
        }
      )
    )
    v(1em)
    // institution
    if institution != none {
      parbreak()
      text(size: 0.7em, fill:self.colors.primary, institution)
    }
    v(1em)
    // conference
    if conference != none {
      parbreak()
      text(size: 1.0em, conference)
      linebreak()
    }
    let locStr = ""
    if location != none {
      locStr = [, #location]
    }
    // date
    if date != none {
      if conference == none {
        parbreak()
      }
      text(size: 1.0em,
        if opts.lang == "de" {
          [#date.day(). #translatedMonth(date, opts.lang) #date.year()#locStr]
        } else {
          [#translatedMonth(date, opts.lang) #date.day(), #date.year()#locStr]
        }
      )
    }
  }

  touying-slide(self: self, body)
})

#let outline-slide(
  ..args,
) = touying-slide-wrapper(self => {
  let opts = options.final()
  let new-config = utils.merge-dicts(
    opts,
    config-page(
      margin: (top: 2em, left: 1em),
      header: none,
      footer: none,
      background:
        place(image("./../assets/bg-umit.jpg"))
        + box(fill: self.colors.primary.transparentize(15%).lighten(75%), height:100%, width: 100%)
    ),
  )

  self = utils.merge-dicts(self, new-config)

  let cntOutline = counter("outline")

  let body = {
    show: align.with(horizon)

    show outline.entry.where(level: 1): it => {
      cntOutline.step()

      link(it.element.location(), grid(
        columns: (-5em, 1fr),
        gutter: 10em,
        // block(
        //   fill: self.colors.primary,
        //   inset: 4pt,
        //   strong(context text(
        //     fill: white,
        //     cntOutline.display()),
        //   ),
        // ),
        grid.cell(""),
        block(
          fill: gradient.linear(
            self.colors.primary,
            self.colors.primary.transparentize(100%),
            relative: "parent",
          ),
          width: 75%,
          inset: 6pt,
          strong(text(
            fill: white,
            it.indented(it.prefix(), it.body())
          ))
        ),
      ))
      v(1em)
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
  ..args,
) = touying-slide-wrapper(self => {
  let opts = options.final()
  let new-config = utils.merge-dicts(
    opts,
    config-page(
      margin: 0pt,
      header: none,
      footer: none,
      background:
        place(image("./../assets/bg-umit.jpg"))
        + box(fill: self.colors.primary.transparentize(45%).lighten(75%), height:100%, width: 100%)
    ),
  )

  self = utils.merge-dicts(self, new-config)
  self.store.title = ""

  let body = {
    set text(size: 1.5em, fill: self.colors.neutral-lightest, weight: "bold")
    v(-4em)
    block(
      width: 100%,
      fill: self.colors.primary.transparentize(10%),
      inset: (x: 2em, y: .8em),
      utils.display-current-heading(level: level, numbered: numbered)
    )
  }

  touying-slide(self: self, body)
})
