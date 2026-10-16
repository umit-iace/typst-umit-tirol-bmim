// expect-error: Option 'section-slide' must be auto, none or a function
#import "/src/lib.typ" as bmim
#show: bmim.slides(title: [Title], section-slide: [Section])
= Section
