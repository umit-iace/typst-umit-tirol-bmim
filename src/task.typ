#import "utils.typ"
#import "options.typ": options, color
#let t-count = counter("task")
#let t-points = state("task-points", ())
#let t-solutions = state("task-solutions", ())
#let inline = "inline"
#let bottom = bottom // for re-exporting in package namespace

#let total-count() = t-count.final().first()
#let task-points() = t-points.final().map(array.sum.with(default: 0))
#let total-points() = task-points().sum(default:0)

#let t-mark = metadata("task-locator")
#let t-label(lbl) = label(str(lbl)+"-tsk")
#let t-label-sol(lbl) = label(str(lbl)+"-sol")


#let style-heading(lbl, tasknum, points, task) = context [
  #let spell = options.final().spell
  #show heading: set block(above: 0pt)
  #block(above:1.2em, below:0pt,sticky:true, lbl)
  = #spell.task #tasknum #h(1fr) #spell.poi: #points <bmim:nonumber>

  #task
]

#let style-enum(lbl, tasknum, points, task) = context [
  #let opts = options.final()
  + #lbl#task
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
  for (num, solution) in t-solutions.final().enumerate(start:1) [
    = Lösung zu #ref(t-label(num)) <bmim:nonumber>

    #query(selector(t-label(num))).map(it => it.location().position()).map(it => link(it, repr(it))).join([\ ])

    #solution
  ]
}

#let task(..args) = {
  let is-super = "points" not in args.named()
  let lbl = if "label" in args.named() { args.named().label }

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

          #args.pos().slice(1).map(it => {
            let lbl = if "label" in it [ #t-mark#it.label ]
            [+ #lbl#t-count.step(level:2) #it.description]
          }).join()
    ] else { args.named().description }

    // show descriptions
    (opts.task-show)(
      [#t-mark#t-label(tasknum)] +
      if lbl != none [#t-mark#lbl],
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
      t-solutions.update(p => { p.push(solution); return p})
    }
  }
}

#let show-ref(it) = {
  let t = str(it.target)
  let opts = options.final()
  let el = it.element
  if el != none and el.func() == metadata and el == t-mark {
    let supp = it.supplement
    if supp == auto {
      supp = opts.spell.task
    }
    let loc = el.location()

    // repr(it)
    // // let num = enum-numbering-state.at(loc)
    // // if std.type(num) != str {
    // //   num = num.with(loc:loc)
    // // }
    // // let ref-counter = numbering(num, ..enum-counter.at(loc))
    let ref-counter = text(blue)[need number]
    if utils.is-empty(supp) {
      link(el.location(), ref-counter)
    }
    else {
      link(el.location(), box([#supp~#ref-counter]))
    }
  } else {
    it
  }
}


#let points-table = context {
  let n = total-count()
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

#{
  show: it=> page(columns:2, it)
  place(points-table, float:true, scope:"parent", auto)

  let multitask(i) = task(
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

  multitask(1)
  context t-points.get()
  multitask(2)
  context t-points.get()
  multitask(3)
  context t-points.get()
  multitask(4)
  context t-points.get()
  multitask(5)
  context t-points.get()

  task(
    points: 5,
    description: [ single points task description ],
    solution: [ this is how ],
  )

  solution-bottom
}
