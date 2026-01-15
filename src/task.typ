#import "list.typ": enum-label
#import "options.typ": options, color
#let t-count = counter("task")
#let t-points = state("task-points", ())
#let t-solutions = state("task-solutions", ())
#let inline = "inline"
#let bottom = bottom // for re-exporting in package namespace

#let task-total-count() = t-count.final().first()
#let task-points() = t-points.final().map(array.sum.with(default: 0))
#let task-total-points() = task-points().sum(default:0)


#let show-task-heading(tasknum, points-total, task) = context [
  #let opts = options.final()
  = #opts.spell.task #tasknum #h(1fr) #opts.spell.poi: #points-total <bmim:nonumber>
  #task
]

#let show-task-enum(tasknum, points-total, task) = context [
  #let opts = options.final()
  + #enum-label("task-"+str(tasknum)) #task
]

#let solution-inline(solution) = {
  block(
    width: 100%,
    fill: color.red.lighten(0%),
    inset: 2pt,
    breakable: true,
    block(
      stroke: 0.5pt,
      width: 100%,
      fill: white,
      inset: 0.3em,
      breakable: true,
    )[
      *Lösung:*

      #solution
    ]
  )
}

#let solution-bottom = context {
  for (num, solution) in t-solutions.final() {
    let num = str(num)
    let lbl = label("sol-"+num)
    context if query(selector(lbl).before(here())).len() == 0 [
      = Lösung zu Aufgabe #num #lbl <bmim:nonumber>

      #solution
    ]
  }
}

#let task(..args) = {
  let is-super = "points" not in args.named()

  let points-or-empty = {
    if is-super { () } else { (args.named().points,).flatten() }
  }

  t-count.step()
  t-points.update(p => { p.push(points-or-empty); return p });

  context {
    let opts = options.final()
    let tasknum = t-count.get().first()

    if is-super {
      // store points
      for (sub, arg) in args.pos().slice(1).enumerate() {
        t-points.update(p => {p.last().push(arg.points); return p})
      }
    }
    let points = t-points.final().at(tasknum - 1, default:())
    let description = if is-super [
          #args.pos().first()

          #args.pos().slice(1).map(it =>
            [+ #metadata("")<bmim-subtask>#t-count.step(level:2) #it.description]
          ).join()
    ] else { args.named().description }

    // show descriptions
    (opts.task-show)(
      tasknum,
      points.sum(default:0),
      description
    )

    let show-points(p) = text(
      fill: color.green,
      grid(
        columns: 2,
        repeat("." + h(2.5pt)),
        [$Sigma$ #p P.]
      )
    )

    let sol-style = if is-super { (it, p) => [+ #it \ #show-points(p) ] }
                    else { (it, p) => [#it \ #show-points(p) ] }
    let solution = (if is-super {
      args.pos().slice(1).map(sub => sub.solution).zip(points)
    } else {(
      (args.named().solution, points.first(default:0)),
    )}).map(tmp => sol-style(..tmp)).join()

    // inline solutions
    if opts.show-solution == inline {
        solution-inline[

          #solution
        ]
    } else if opts.show-solution == bottom {
      t-solutions.update(p => { p.push((tasknum, solution)); return p})
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


#let task-table = context {
  let n = task-total-count()
  let points = task-points()
  show table.cell.where(y: 0): strong

  table(
    columns: (1fr,)*(n + 2),
    rows: (auto, auto, 2em),
    align: center,
    ..range(1,n+1).map(str), $Sigma$, [Note],
    ..points.map(str), str(points.sum(default:0)), [],
    ..range(n+2).map(it => [])
  )
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

#solution-bottom
