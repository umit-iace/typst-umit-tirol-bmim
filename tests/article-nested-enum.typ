// expect-text: a) One i) Two 1) Three 2) Three ii) Two b) One
#import "/src/lib.typ" as bmim
#show: bmim.article(title: [T], authors: ([A],))
+ One
  + Two
    + Three
    + Three
  + Two
+ One
