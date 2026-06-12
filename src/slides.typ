#import "@preview/touying:0.7.3": *
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
      header: none,
      footer: none,
      background: place(
        box(fill: gradient.linear(self.colors.primary, self.colors.primary.darken(100%), angle: 90deg), height: 100%, width: 100%)
      )
    ),
    config-common(freeze-slide-counter:true),
  )

  self = utils.merge-dicts(self, new-config)

  let authors = (self.info.authors,).flatten()
  let title = (self.info.title,).flatten()
  let subtitle = self.info.subtitle
  let institution = self.info.institution
  let conference = self.info.conference
  let location = self.info.location
  let date = self.info.date

  let bold(size, body) = strong(text(size: size, body))

  let body = {
    set align(center + horizon)
    set text(fill: self.colors.background)
    v(-3.0em)
    // authors
    block(
      width: 100%,
      align(left,
      text(size: 0.95em)[#authors.join[, ]] + if institution != none [
        #line(length: 20%, stroke: self.colors.highlight) #v(-0.5em)
        #text(size: 0.75em)[#institution.join[\ ]]
      ])
    )
    v(0.5em)
    block(
      width: 100%,
      fill: self.colors.highlight,
      inset: 1.5em,
      radius: 0.25em,
      breakable: false,
      {
        bold(1.75em, text(fill: self.colors.background)[#title.at(0, default:none)])
        if subtitle != none {
          parbreak()
          bold(1.0em, text(fill: self.colors.background)[#subtitle])
        }
      },
    )
    v(2em)

    let locStr = ""
    if location != none {
      locStr = [, #location]
    }
    grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0pt,
      grid.cell(align(left, pad(top: -0mm,
        image("./../assets/logo_iace_white.svg", height: 2.65em)
      ))),
      grid.cell([
        // conference
        #if conference != none {
          parbreak()
          text(size: 1.0em, conference)
          linebreak()
        }
        // date
        #if date != none {
          if conference == none {
            parbreak()
          }
          text(size: 1.0em,
          if opts.lang == "de" {
            [#date.day(). #translatedMonth(date, opts.lang) #date.year()#locStr]
          } else {
            [#translatedMonth(date, opts.lang) #date.day(), #date.year()#locStr]
          })
        }
      ]),
      grid.cell(align(right, pad(
        top: 1em,
        image("./../assets/logo_umit_white_gr.svg", height: 2.65em)
      ))),
    )
  }

  touying-slide(self: self, body)
})

#let outline-slide(
  coverLvl: 1,
  ..args,
) = touying-slide-wrapper(self => {
  let opts = options.final()
  let new-config = utils.merge-dicts(
    opts,
  )

  self = utils.merge-dicts(self, new-config)

  let cntOutline = counter("outline")
  cntOutline.update(1)

  let body = {
    show: align.with(horizon)
    show heading: none
    show outline.entry.where(level: 1): it => {
      cntOutline.step()
      let style(entry) = block(
          fill: gradient.linear(
            if cntOutline.get().at(0) == coverLvl {
              self.colors.primary.lighten(50%)
            } else {
              self.colors.primary.lighten(5%)
            },
            self.colors.primary.lighten(5%).transparentize(100%),
            relative: "parent",
          ),
          width: 100%,
          inset: 6pt,
          strong(text( fill: white, cntOutline.display() + h(1em) + entry ))
        )
      link(it.element.location(), style( it.body() ))
      []
      v(1em)
    }

    pad(x: 2.5em, outline(depth: 1, ..args))
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
      background: place(image("./../assets/background_umit.jpg")) + box(fill: self.colors.primary.transparentize(45%).lighten(75%), height:100%, width: 100%)
    ),
  )

  self = utils.merge-dicts(self, new-config)
  self.store.title = ""

  let body = {
    set text(size: 1.5em, fill: self.colors.neutral-lightest, weight: "bold")
    v(-4em)
    block(
      width: 100%,
      fill: gradient.linear(
        self.colors.primary.lighten(5%),
        self.colors.primary.lighten(5%).transparentize(100%),
        relative: "parent",
      ),
      inset: (x: 2em, y: .8em),
      utils.display-current-heading(level: level, numbered: numbered)
    )
  }

  touying-slide(self: self, body)
})
