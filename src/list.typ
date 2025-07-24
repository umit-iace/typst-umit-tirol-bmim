#let enum-label-mark = metadata("enumeration_label")
#let enum-counter = counter("enum-counter")
#let enum-numbering-state = state("enum-numbering", none)

#let enum-label(label) = {
  if type(label) == content {
    // informative error message
    assert(label.has("text"), message: "enum-label requires text content")
    label = label.text
  }
  [#enum-label-mark#std.label(label)]
}

#let wrapped-enum-numbering(numbering) = {
  let enum-numbering = (..it,) => {
    enum-numbering-state.update(x => numbering)
    enum-counter.update(it.pos())
    std.numbering(numbering, ..it)
  }
  enum-numbering
}

#let is-empty(value) = {
  let empty-values = (
    array: (),
    dictionary: (:),
    str: "",
    content: [],
  )
  let t = repr(type(value))
  if t in empty-values {
    return value == empty-values.at(t)
  } else {
    return value == none
  }
}
