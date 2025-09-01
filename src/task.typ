#import "utils.typ": *
#import "colors.typ": *

#let task-points = state("bmim-tasks-points", ())
#let tasks = state("bmim-tasks", ())
#let task-cnt = counter("bmim-task")

#let task(points: float, task: content, solution: content) = context {
  task-cnt.step()
  let task-with-sol = state("bmim-tasks-with-sol", false).get()
  let sol-at-end = state("bmim-tasks-sol-at-end", false).get()
  let task-with-points = state("bmim-tasks-with-points", false).get()
  task-points.update(task-points => task-points + (points,))
  let h1-num = counter(heading).get().first()
  let problem-number = numbering("1.1", h1-num, ..task-cnt.get())
  let name = [Exercise #problem-number]
  let ctask = (sol: solution, location: here(), name: name)
  tasks.update(tasks => tasks + (ctask,))
  // Display task
  [
    #task
  ]
  if task-with-sol and sol-at-end == false {
    block(width: 100%, stroke: (paint: black.lighten(60%), thickness: 0.275em), inset: 0.5em)[
      #text(weight: "bold")[#str(dictSpell.at(text.lang).at("sol")).replace(regex("^\w"), m=>upper(m.text))]: #h(0.1em)#solution
      #if task-with-points {
        linebreak()
        text(bmimred)[#h(1fr) .../#points P.]
      }
    ]
  }
}

#let show-task-sol() = context for p in tasks.get() {
  if p.sol == none { continue }
  let task-link = link(p.location, emph(p.name))
  block[_Solution:_ #task-link#h(1em)#p.sol]
}
