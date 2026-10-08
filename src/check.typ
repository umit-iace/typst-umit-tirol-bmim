// Assert that the option `name` is set, i.e. not none.
#let assert-set(name, value) = assert(
  value != none,
  message: "Option '" + name + "' must be set",
)

// Assert that the option `name` has one of the `allowed` values.
#let assert-one-of(name, value, allowed) = assert(
  value in allowed,
  message: "Option '" + name + "' must be one of [" +
    allowed.map(repr).join(", ") +
    "], but was set to " + repr(value),
)
