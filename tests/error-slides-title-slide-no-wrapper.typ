// expect-error: Option 'title-slide' must return a touying-slide-wrapper
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [Title], title-slide: (..args) => [Title slide])
#bmim.title-slide()
