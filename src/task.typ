#import "options.typ": options
#let t-count = counter("task")
#let t-points = state("task-points", ())
#let t-solutions = state("task-solutions", ())
#let inline = "inline"


#let task(..args) = {
  set heading(offset:
    if "offset" in args.named() {
      args.named().offset
    } else { 0 }
  )
  let is-super = "points" not in args.named()
  let points-or-zero = {
    if is-super { 0 } else { args.named().points }
  }
  let show-or-store(cnt, solution) = {
    let opts = options.final()
    if opts.show-solution == "inline" {
      box(
        fill: luma(95%),
        radius:1pt,
        inset: (y:0.1em),
        outset: (x:0.1em),
        width: 100%,
      [
        == Lösung <bmim:nonumber>
        #solution
      ]
    )
    } else if opts.show-solution == bottom {
      // let cnt = t-count.get()
      t-solutions.update(s => {s.push(
        (cnt, solution)
      ); return s});
    }
  }
  t-count.step()
  t-points.update(p => { p.push(points-or-zero); return p });
  context [
    #let ex = t-count.get().first()
    = Aufgabe #ex <bmim:nonumber>

    * Punkte:* #if ex > 0 {t-points.final().at(ex - 1)}
    #v(.5em)
  ]
  if is-super {
    // description
    [
      #args.pos().first()

    ]
    for (sub, arg) in args.pos().slice(1).enumerate() {
      // t-count.step(level:2)
      t-points.update(p => {p.last() += arg.points; return p})
      [
        + #arg.description\
          #context show-or-store((t-count.get().first(),sub+1), arg.solution)
      ]
    }
  } else {
    let description = args.named().description
    let solution = args.named().solution
    [
      #description

      #context show-or-store(t-count.get(), solution)
    ]
  }
}


#let task-show-table = context {
  let n = t-count.final().first()
  let points = t-points.final()

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
#place(task-show-table, float:true, scope:"parent", auto)

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
