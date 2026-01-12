#import "/src/lib.typ": *
#import "@preview/layout-ltd:0.1.0": layout-limiter
#show: layout-limiter.with(max-iterations: 4)



#show: bmim-exam(
  title: "Eingangstest",
  course: ([Advanced Control],[AC]),
  authors: ("Author1", "Author3", "Author3"),
  show-solution: inline,
  total-time: [90min],
  lang: "en",
)

#task(
  [
    Das Eingangs-Ausgangsverhalten eines Systems wird durch die Übertragungsfunktion
    $
    G(s) & = frac(s+2, 2 s^(2) - 2 s + 1)
    $
    beschrieben. <task:main>
  ],
  (
    points: 10,
    description: [
      Geben Sie eine Realisierung der Übertragungsfunktion in
      Regelungsnormalform an. <task:sub>
    ],
    solution: [
      Regelungsnormalform:
      $
      dot(bold(x)) & = mat(0, 1; -frac(1,2), 1) bold(x) + mat(0; 1) u \
      y & = mat(1, frac(1, 2)) bold(x)
      $
    ]
  ),
  (
    points: 30,
    description: [
      Ist die interne Dynamik des Systems stabil?
      Begründen Sie Ihre Antwort.
    ],
    solution: [
      Die Eigenwerte der internen Dynamik entsprechen den Zählernullstellen.
      Diese sind durch die Lösungen von $s+2=0$ durch $s=-2$ gegeben und somit ist die interne Dynamik in Folge des negativen Realteils stabil.
    ]
  )
)
#task(
  [

    Betrachtet wird das System
    $
    dot(x)_1 = x_2, #h(5em)
    dot(x)_2 = x_3, #h(5em)
    dot(x)_3 = x_2 - x_3 + u
    $
    mit dem Ausgang
    $
    y & = x_1 + 2 x_2 + x_3.
    $

  ],
  (
    points: 20,
    description: [
      Wie heißt die spezielle Zustandsdarstellung in der das System gegeben ist?
    ],
    solution: [
      Das System liegt in Regelungsnormalform vor.
    ]
  ),
  (
    points: 20,
    description: [
      Welchen relativen Grad besitzt das System?
      Begründen Sie Ihre Antwort.
    ],
    solution: [
      Der relative Grad des Systems ist eins.
      Dies kann entweder direkt aus der Ausgangsmatrix $c^(sans(upright(T)))=(1,1,1)$ abgelesen werden oder aber durch Differentiation des
      Ausgangs:
      $
      dot(y) & = dot(x)_1 + 2 dot(x)_2 + dot(x)_3 = x_2 + 2 x_3 + x_2 - x_3 + u = 2 x_2 + x_3 + u.
      $
    ]
  )
)

#task(
  points: 5,
  description: [ single points task description referencing @task:main and also
  @task:sub],
  solution: [ this is how to also reference from solution @task:sub],
)



