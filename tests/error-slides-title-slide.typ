// expect-error: Option 'title-slide' must be auto or a function
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [Title], title-slide: [Title slide])
#bmim.title-slide()
