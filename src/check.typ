// Subject of an error message: an option, or an argument of a function.
#let _subject(name, of) = if of == none {
  "Option '" + name + "'"
} else {
  "Argument '" + name + "' of " + of
}

// Assert that the option `name` (or the argument `name` of `of`) is set,
// i.e. not none.
#let assert-set(name, value, of: none) = assert(
  value != none,
  message: _subject(name, of) + " must be set",
)

// Assert that the option `name` (or the argument `name` of `of`) has one of
// the `allowed` values.
#let assert-one-of(name, value, allowed, of: none) = assert(
  value in allowed,
  message: _subject(name, of) + " must be one of [" +
    allowed.map(repr).join(", ") +
    "], but was set to " + repr(value),
)

// Assert that the argument sink `args` of the function `of` holds no named
// arguments, i.e. that no unknown (e.g. misspelled) argument was given.
#let assert-no-extra(args, of) = assert(
  args.named().len() == 0,
  message: "Unknown argument(s) of " + of + ": " +
    args.named().keys().join(", "),
)

// Check and normalize the option 'header-image' (slides, poster): none or
// false switch it off (none), true gives the mountain panorama with the
// defaults, a dictionary selects the section (`x`, `y`, `width`) and the
// `overlay`, content is an own image, shown as given.
#let header-image-option(header-image) = {
  assert(
    header-image == none or type(header-image) in (bool, dictionary, content),
    message: "Option 'header-image' must be none, false, true, a dictionary or content, but was set to " + repr(header-image),
  )
  // the mountain panorama: the section of the image with `width` of the image
  // width around the point (`x`, `y`) of the image is shown, `overlay` is the
  // opacity of the primary color above it
  let panorama-defaults = (x: 50%, y: 60%, width: 100%, overlay: 75%)
  if type(header-image) == dictionary {
    for (key, value) in header-image {
      assert(key in panorama-defaults, message:
        "Unknown key '" + key + "' of option 'header-image', known keys are [" +
        panorama-defaults.keys().map(repr).join(", ") + "]")
      assert(type(value) == ratio and value >= 0% and value <= 100%, message:
        "Key '" + key + "' of option 'header-image' must be a ratio between 0% and 100%, but was set to " + repr(value))
    }
    assert(header-image.at("width", default: 100%) > 0%, message:
      "Key 'width' of option 'header-image' must be greater than 0%")
  }
  if header-image in (none, false) { none }
  else if header-image == true { panorama-defaults }
  else if type(header-image) == dictionary { panorama-defaults + header-image }
  else { header-image }
}
