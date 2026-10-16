// expect-error: Option 'outline-slide' must return a touying-slide-wrapper
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [Title], outline-slide: (..args) => [Outline])
#bmim.outline-slide()
