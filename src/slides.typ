#import "@preview/touying:0.6.3": *

#let config-info = (
  title: none,
  short-title: none,
  subtitle: none,
  authors: none,
  conference: none,
  institution: none,
  date: none,
)

#let slide(
  title: auto,
  header: auto,
  footer: auto,
  align: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  if title != auto {
    self.store.title = title
  }
  if header != auto {
    self.store.header = header
  }
  if footer != auto {
    self.store.footer = footer
  }
  let new-setting = body => {
    show: std.align.with(self.store.align)
    show: setting
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})

#let title-slide(
  config: (:),
  ..args) = touying-slide-wrapper(self => {
  let new-config = config
  new-config = utils.merge-dicts(
    config,
    config-page(
      footer: none,
      margin: (top: 4em, left: 1em),
    ),
    config-common(freeze-slide-counter:true),
  )

  self = utils.merge-dicts(self, new-config)

  let info = self.info + args.named()

  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }

    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }

  let body = {
    show: align.with(center + horizon)
    block(
      fill: self.colors.background,
      inset: 1.5em,
      radius: 0.5em,
      breakable: false,
      {
        text(size: 1.4em, fill: self.colors.primary, weight: "bold", info.title)
        if info.subtitle != none {
          parbreak()
          text(size: 1.0em, fill: self.colors.primary, weight: "bold", info.subtitle)
        }
      },
    )
    // authors
    grid(
      columns: (1fr,) * calc.min(info.authors.len(), 3),
      column-gutter: 1em,
      row-gutter: 1em,
      ..info.authors.map(author => text(fill: black, author)),
    )
    v(0.5em)
    // institution
    if info.institution != none {
      parbreak()
      text(size: 0.7em, fill: self.colors.primary, weight: "bold", info.institution)
    }
    // conference
    // if info.conference != none {
    //   parbreak()
    //   text(size: 1.0em, info.conference)
    //   linebreak()
    // }
    // date
    if info.date != none {
      if info.conference == none {
        parbreak()
      }
      if type(utils.display-info-date(self)) == datetime {
        text(size: 1.0em, utils.display-info-date(self))
      } else {
        text(size: 1.0em, utils.display-info-date(self))
      }
    }

  }

  touying-slide(self: self, body)
})

#let outline-slide(
  config: (:),
  ..args) = touying-slide-wrapper(self => {
  let new-config = config
  new-config = utils.merge-dicts(
    config,
    config-page(
      margin: (top: 2em, left: 1em),
    ),
  )

  self = utils.merge-dicts(self, new-config)

  let info = self.info + args.named()

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
  config: (:),
  level: 1,
  numbered: true,
  ..args) = touying-slide-wrapper(self => {
  let new-config = config
  new-config = utils.merge-dicts(
    config,
    config-page(
      margin: (top: 4em, left: 1em),
    ),
  )

  self = utils.merge-dicts(self, new-config)
  self.store.title = ""

  let info = self.info + args.named()

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
