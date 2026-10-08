// expect-text: ordinal ok
#import "/src/helpers.typ": ordinal-suffix
#assert.eq(
  (1, 2, 3, 4, 11, 12, 13, 21, 22, 23, 24, 30, 31).map(d => str(d) + ordinal-suffix(d)),
  ("1st", "2nd", "3rd", "4th", "11th", "12th", "13th", "21st", "22nd", "23rd", "24th", "30th", "31st"),
)
ordinal ok
