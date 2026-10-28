// expect-error: The content of the back page of the flyer is too high for the back image
#import "/src/lib.typ" as bmim
#show: bmim.flyer(
  title: [T],
  back-image: image("/assets/background_bettelwurf.jpg"),
)
#lorem(2000)
