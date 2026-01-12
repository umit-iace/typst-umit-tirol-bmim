#import "/src/lib.typ": *

#show: bmim-workbook(
	course: [VU Modellbildung und Simulation 1],
	authors: ([Luca Mayer], [Frank Woittennek]),
	lang:"de",
)


= Dynamische Systeme

// #[
// #set heading(offset: 1)
#task(
	// [= Fliehkraftregler],
[zeigt den mechanischen Teil eines Fliehkraftreglers. Darin bezeichnen das Drehmoment M(t), die
Winkelgeschwindigkeit ω(t) und der Winkel α(t) die Systemgrößen. Die Masse m, die Länge ℓ und die
Erdbeschleunigung g sind konstante Parameter. Die nichtlinearen Modellgleichungen für das betrachtete
System seien durch
$
m l^2 ( dot(omega) (t) sin^2(alpha (t)) + omega(t) dot(alpha)(t) sin(2 alpha(t))) &= M(t)\
2 l dot.double(alpha)(t) - l omega^2(t) sin(2 alpha(t)) &= -2g sin(alpha(t))
$ <eq:fliehkraftregler>
gegeben. <task:fkr>
],
(
	points: 0,
	description: [
		Wählen Sie das Drehmoment $M(t)$ als Eingang, den Winkel
		$alpha(t)$ als Ausgang und gegben Sie eine Zustandsdarstellung des
		nichtlinearen Systems zu diesem Eingang an. <task:sub>
	],
	solution: [],
),
(
	points: 0,
	description: [
		Geben Sie sämtliche Ruhelagen $(dash(alpha), dash(M), dash(omega))$ des
		Systems @eq:fliehkraftregler an.
		#hint(plural: false)[$sin(2alpha) = 2sin(alpha)cos(alpha)$]
		w/e @task:fkr before @task:sub
	],
	solution: [],
),
)


== first subs
#lorem(30)
== second subs
#lorem(30)
// ]

#pagebreak()

#lorem(30)

= Second
#lorem(30)

#pagebreak()

#lorem(30)
