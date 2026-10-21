// Contents of the poster boxes, shared by poster-landscape.typ and
// poster-portrait.typ: the same boxes, only the layout differs.
#import "./preamble.typ": *

// gray placeholder for a figure
#let placeholder(height, label: [Abbildung]) = rect(
  width: 100%,
  height: height,
  fill: luma(225),
  stroke: luma(185),
  align(center + horizon, text(luma(120), label)),
)

#let caption(body) = align(center, text(0.8em, emph(body)))

// topics on the left, details on the right
#let focus(..items) = grid(
  columns: (35%, 1fr),
  gutter: 0.6em,
  align: horizon,
  ..items.pos().map(((topic, points)) => (
    rect(width: 100%, inset: 0.6em, radius: 0.4em, fill: bmim.color-cd2026.blue,
      align(center, text(white, topic))),
    rect(width: 100%, inset: 0.6em, radius: 0.4em, fill: luma(215),
      text(0.8em, list(..points))),
  )).flatten()
)

#let boxes = (
  power-plant: poster-box[Großgasmotorenkraftwerke][
    #grid(
      columns: (3fr, 2fr),
      gutter: 0.8em,
      [
        - Ein Großgasmotorenkraftwerk ist ein Verbund mehrerer Großgasmotoren,
          die Regelreserve zur Frequenzregulierung und Wärme zum Heizen
          bereitstellen.
        - So kann ein Gesamtwirkungsgrad von bis zu $95 %$ erreicht werden.
        - Anforderungen:
          - Schnelle Verfügbarkeit
          - Geringe Emission auch bei transienten Vorgängen
          - Energieoptimales Verhalten auch im Teillastbetrieb
          - Hoher Wirkungsgrad und hohe Zuverlässigkeit
      ],
      [
        #image("/assets/background_umit.jpg", width: 100%)
        #caption[Großgasmotorenkraftwerk]
      ],
    )
  ],

  research: poster-box[Forschungsschwerpunkte][
    #focus(
      ([Modellierung], ([Teilsysteme (z.B. Kühlkreisläufe, SCR)], [Gesamtsystem (Großgasmotor)], [Kraftwerk (Motorenverbund)])),
      ([Entwicklung neuer Regelkonzepte], ([Auf Basis der Modelle], [Optimales Verhalten der Teilsysteme sicherstellen])),
      ([Entwicklung von Diagnosemethoden], ([Standzeiten und Wartungszeiten optimieren], [Fehlertolerante Regelung ermöglichen])),
    )
  ],

  control: poster-box[Die Regelung eines Großgasmotors aus Systemsicht][
    #grid(
      columns: (3fr, 2fr),
      gutter: 0.8em,
      [
        Um eine optimale Regelung von Großgasmotoren zu ermöglichen, ist ein
        sehr gutes Zusammenspiel von
        - Motorregelung,
        - Kühlkreislaufregelung,
        - Emissionsregelung und
        - Fehlerdiagnosealgorithmen
        sicherzustellen.
      ],
      placeholder(6em),
    )
  ],

  cooling: poster-box[Kühlkreisläufe eines Großgasmotors][
    - Ladeluftkühlkreislauf (zweistufig)
    - #text(bmim.color.yellow)[Motorkühlwasserkreislauf (einstufig)]
    - #text(bmim.color.green)[Ölkühlkreislauf (ein- oder zweistufig)]
    #placeholder(8em)
    #caption[Mögliche Verschaltungsvariante der Motorkühlkreisläufe]
  ],

  cooling-water: poster-box[Motorkühlwasserkreislauf am J920 Großgasmotor][
    #grid(
      columns: (1fr, 1fr),
      gutter: 0.8em,
      align: horizon,
      [
        #placeholder(6em)
        #caption[MKW-Kreis am Prüfstand]
      ],
      table(
        columns: 2,
        stroke: none,
        table.hline(),
        [Kreisläufe], [2],
        [Pumpen], [2],
        [Mischventile], [2],
        [Tischkühler], [4],
        [Ventilatoren], [40],
        [Leitungslänge], [214 m],
        [Wasservolumen], [15.7 m#super[3]],
        table.hline(),
      ),
    )
  ],

  shower: poster-box[Regelung von Totzeitsystemen am Beispiel einer Dusche][
    System:
    $
      T_1(t) & = H(t) T_"W" (t) + (1 - H(t)) T_"K" (t), \
      T_2(t) & = T_1(t - tau), quad tau = (l d^2 pi) / (4 dot(V))
    $
    #set text(0.8em)
    #table(
      columns: 3,
      stroke: none,
      table.hline(),
      [Mischtemperatur], $T_1$, [°C],
      [Austrittstemperatur], $T_2$, [°C],
      [Schlauchlänge], $l$, [1.5 m],
      [Innendurchmesser], $d$, [0.01 m],
      [Volumenstrom], $dot(V)$, [14 l/min],
      [Totzeit], $tau$, [0.5 s],
      table.hline(),
    )
  ],

  catalyst: poster-box[Emissionsreduktion mittels SCR-Katalysator][
    #placeholder(6em)
    #caption[Schematische Darstellung eines SCR-Katalysators]
    #align(center)[
      *Vorrangige Reaktionen* \
      _Schnelle SCR:_
      $4 "NH"_3 + 2 "NO" + 2 "NO"_2 -> 4 "N"_2 + 6 "H"_2"O"$ \
      _Standard-SCR:_
      $4 "NH"_3 + 4 "NO" + "O"_2 -> 4 "N"_2 + 6 "H"_2"O"$
    ]
  ],

  diagnosis: poster-box[Modellbasierte Systemdiagnose][
    #image("/assets/background_bettelwurf.jpg", width: 100%)
    #caption[Möglicher Aufbau eines Diagnosesystems]
  ],
)

// box in the shape of a right angle: heading and text over the full width,
// below on one side the figure, `inner` fills the corner
#let cooling-angle(inner, at: left, widths: (1fr, 1fr)) = bmim.poster-angle(
  heading: [Kühlkreisläufe eines Großgasmotors],
  top: [
    Ein Großgasmotor besitzt mehrere Kühlkreisläufe, deren Zusammenspiel
    Wirkungsgrad und Emissionen bestimmt:
    - Ladeluftkühlkreislauf (zweistufig)
    - #text(bmim.color.yellow)[Motorkühlwasserkreislauf (einstufig)]
    - #text(bmim.color.green)[Ölkühlkreislauf (ein- oder zweistufig)]
  ],
  side: [
    #placeholder(10em)
    #caption[Mögliche Verschaltungsvariante der Motorkühlkreisläufe]
  ],
  inner: inner,
  at: at,
  widths: widths,
)
