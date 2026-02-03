#import "@local/typst-umit-tirol-bmim:0.2.0" as bmim: poster-box

#show: bmim.poster(
	title:[Regelungskonzepte für hochtransiente, effizienz- und emissionsoptimierte
	Großgasmotorenkraftwerke],
	authors:(
		[S. Bachler, C. Horngacher & Prof. Dr. F. Woittennek (IACE / Umit, Hall in Tirol)],
		[Dr. J. Huber, Dr. H. Kopecek & Dr. K. Spreitzer (GE Power / Jenbach)]
	),
	contact: [`simon.bachler@umit.at`],
	event: [Lange Nacht der Forschung],
	location: [Umit, Hall in Tirol],
)

#poster-box[Großgasmotorenkraftwerke][
- Ein Großgasmotorenkaftwerk ist ein Verbund mehrerer Großgasmotoren, welche
	- Regelreserve zur Frequenzregulierung und
  - Wärme zum Heizen bereitstellen.
- So kann ein Gesamtwirkungsgrad von bis zu 95% erreicht werden.
- Anforderungen:
	- Schnelle Verfügbarkeit.
	- Geringe Emission auch bei transienten Vorgängen.
	- Energieoptimales Verhalten auch im Teillastbetrieb.
	- Hoher Wirkungsgrad.
	- Hohe Zuverlässigkeit
]



#poster-box(height:1fr)[Forschungsschwerpunkte][
	Do try @tab:try.
	#figure(
		table(
			columns: 4,
			..(context{counter("a").step(); str(counter("a").get().first())},)*8,
		),
		caption: [Try me! #lorem(20)],
	) <tab:try>
]
#colbreak()

#poster-box[Die Regelung eines Großgasmotors aus Systemsicht][
Um eine optimale Regelung von Großgasmotoren zu ermöglichen, ist ein sehr gutes
Zusammenspiel von
- Motorregelung,
- Kühlkreislaufregelung,
- Emissionsregelung und
- Fehlerdiagnosealgorithmen,
sicherzustellen
]
