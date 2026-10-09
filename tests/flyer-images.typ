// expect-text: Mit Bildern
// expect-text: Text oben
#import "/src/lib.typ" as bmim
#show: bmim.flyer(
  title: [Mit Bildern],
  background: image("/assets/background_umit.jpg"),
  back-image: image("/assets/background_bettelwurf.jpg"),
)
Text oben
#bmim.flyer-badge[Badge]
