// expect-error: Entries of option 'lists' must be image, table, raw or (kind: .., title: ..)
#import "/src/lib.typ" as bmim
#show: bmim.lecture(course: [K], authors: ([A],), lists: ((kind: "def"),))
x
