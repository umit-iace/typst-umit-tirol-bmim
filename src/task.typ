#import "options.typ": options
#let t-count = counter("task")
#let t-points = state("task-points", ())
#let t-solutions = state("task-solutions", ())
#let inline = "inline"

#let task(..args) = {
  let is-super = "points" not in args.named()

  let points-or-empty = {
    if is-super { () } else { (args.named().points,).flatten() }
  }

  t-count.step()
  t-points.update(p => { p.push(points-or-empty); return p });

  context {
    let opts = options.final()
    let ex = t-count.get().first()

    if is-super {
      // store points
      for (sub, arg) in args.pos().slice(1).enumerate() {
        t-points.update(p => {p.last().push(arg.points); return p})
      }
    }
    let points = t-points.final().at(ex -1).sum(default: 0)
    let description = if is-super [
          #args.pos().first()

          #args.pos().slice(1).map(it =>
            [+ #metadata("")<bmim-subtask>#t-count.step(level:2) #it.description]
          ).join()
    ] else { args.named().description }

    // show descriptions
    (opts.task-show)(
      ex,
      points,
      description
    )

    let sol = if is-super {
      (args.pos().slice(1).zip(t-points.final().at(ex - 1)).map(((it, p)) =>
      [+ #it.solution\ #opts.spell.poi: #p ]).join(),)
    } else {
      (args.named().solution,)
    }

    // inline solutions
    if opts.show-solution == inline {
      (opts.task-show-solution)(sol)
    }
  }
}

#let task-show-ref(it) = {
  let t = str(it.target)
  if t.starts-with("task:") {
    if it.element == none {
      panic("can't reference <" + t + ">")
    }
    let opts = options.final()
    let loc = it.element.location()
    let c = t-count.at(loc)
    let loc = if c.len() == 1 {
      // locate main task
      let pos = query(selector(heading).before(loc)).last().location().position()
      pos.y += 0.25cm // why is this needed
      pos
    } else {
      // locate beginning of subtask
      let loc = query(selector(<bmim-subtask>).before(loc)).last().location()
      let pos = loc.position()

      let length-from(x) = {
        let t = type(x)
        if t == relative {
          x.ratio * page.width + x.length
        } else if t == length {
          x
        } else {
          panic(t)
        }
      }

      pos.x = if page.margin == auto {
        2.5cm // TODO get actual page margin
      } else {
        length-from(
          if "x" in page.margin {
            page.margin.x
          } else if "left" in page.margin {
            page.margin.left
          } else {
            panic(page.margin)
          }
        )
      }
      pos.y += 0.25cm // why is this needed
      pos
    }
    let nbr = if c.len() == 1 { "1" } else {
      "1."+enum.numbering.trim(regex("[.)]"))
    }
    let num = numbering(nbr, ..c)
    let supp = if it.supplement == auto {
      if c.len() == 1 {opts.spell.task} else {opts.spell.subtask}
    } else {it.supplement}
    link(loc,[#supp~#num])
  } else {
    it
  }
}

#let task-total-count() = t-count.final().first()
#let task-points() = t-points.final().map(array.sum.with(default: 0))
#let task-total-points() = task-points().sum()


#let task-table = context {
  let n = task-total-count()
  let points = task-points()
  show table.cell.where(y: 0): strong

  table(
    columns: (1fr,)*(n + 2),
    rows: (auto, auto, 2em),
    align: center,
    ..range(1,n+1).map(str), $Sigma$, [Note],
    ..points.map(str), str(points.sum()), [],
    ..range(n+2).map(it => [])
  )
}

#let task-solutions = context {
  let opts = options.final()
  if opts.show-solution == inline  {
    return
  } else if opts.show-solution == none {
    pagebreak(to:"even")  * t-count.final().first()
  } else if opts.show-solution == bottom {
    for val in t-solutions.final() {
      let ((task, ..sub), sol) = val
      let frst = str(task)
      let lbl = label("sol-"+frst)
      context if query(selector(lbl).before(here())).len() == 0 [
        = Lösung #frst #lbl <bmim:nonumber>
      ]
      if sub.len() == 0 {
        sol
      } else [
        + #sol
      ]
    }
  }
}

#show: it=> page(columns:2, it)
#place(task-table, float:true, scope:"parent", auto)

#let multitask(i) = task(
  [problem description],
  (
    points: 10*i + 1,
    description: [ sub- description #i - 1],
    solution: [sub -sol #i - 1],
  ),
  (
    points: 10*i + 2,
    description: [ sub- description #i - 2],
    solution: [sub -sol #i - 2],
  ),
  (
    points: 10*i + 3,
    description: [ sub- description #i - 3],
    solution: [sub -sol #i - 3],
  ),
  (
    points: 10*i + 4,
    description: [ sub- description #i - 4],
    solution: [sub -sol #i - 4],
  ),
)

#multitask(1)
#context t-points.get()
#multitask(2)
#context t-points.get()
#multitask(3)
#context t-points.get()
#multitask(4)
#context t-points.get()
#multitask(5)
#context t-points.get()

#task(
  points: 5,
  description: [ single points task description ],
  solution: [ this is how ],
)

#task-solutions
