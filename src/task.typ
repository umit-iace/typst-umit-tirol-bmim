#import "utils.typ": *
#import "colors.typ": *

#let task-points = state("bmim-tasks-points", ())

#let task(points: float, task: content, solution: content) = context {
  let task-with-sol = state("bmim-tasks-with-sol", false).get()
  let task-with-points = state("bmim-tasks-with-points", false).get()
  task-points.update(task-points => task-points + (points,))
  // Display task
  [
    #task
  ]
  if task-with-sol {
    block(width: 100%, stroke: (paint: black.lighten(60%), thickness: 0.275em), inset: 0.5em)[
      #text(weight: "bold")[#str(dictSpell.at(text.lang).at("sol")).replace(regex("^\w"), m=>upper(m.text))]: #h(0.1em)#solution
      #if task-with-points {
        linebreak()
        text(bmimred)[#h(1fr) .../#points P.]
      }
    ]
  }
}
