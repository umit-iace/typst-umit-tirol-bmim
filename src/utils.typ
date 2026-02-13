#import "data.typ": *
#import "options.typ": *

#let backmatter(content) = {
  set heading(numbering: "A.1")
  counter(heading).update(0)
  state("backmatter").update(true)
  content
}

#let translatedMonth(dt, lang) = {
  if lang == "de" {
    months.at(dt.month() - 1)
  } else {
    dt.display("[month repr:long]")
  }
}

#let print-date(date) = {
  let opts = options.final()
  if type(date) != datetime {
    date
  } else [#date.day(). #translatedMonth(date, opts.lang) #date.year()]
}

#let heading-prefix-numbering(..args, loc: none) = context {
  let hdr = counter(heading).at(
    if loc == none { here() } else { loc }
  )
  let chain = hdr + args.pos()
  return chain.map(str).join(".")
}

#let page-is-chap-start() = {
  return query(heading.where(level: 1))
    .map(it => it.location().page())
    .contains(here().page())
}

#let page-number() = numbering(here().page-numbering(), here().page())

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

#let getmarginx() = {
  // TODO actually implement all cases
  if page.margin == auto {
    return 2.5cm
  } else if type(page.margin) == length {
    return page.margin
  } else {
    let it = page.margin.left
    if it == auto {
      return 2.5cm * 2
    }
    return it
  }
}

#let vcard_template = "BEGIN:VCARD
VERSION:4.0
N:__LASTNAME__;__FIRSTNAME__;;__TITLE__;
FN:__TITLE__ __FIRSTNAME__ __LASTNAME__
ORG:UMIT-TIROL
ROLE:__ROLE__
TEL;TYPE=work,voice;VALUE=uri:tel:__TEL__
ADR;TYPE=work;LABEL=\"__STREETNUMBER__\n__ZIP__ __TOWN__\n__COUNTRY__\":;;__STREETNUMBER__;__TOWN__;;__ZIP__;__COUNTRY__
EMAIL:__EMAIL__
REV:__REV__
END:VCARD
"
#let build_vcard(contact) = {
  let rev = (datetime.today().display("[year][month][day]"),"T").join("")
  return vcard_template
    .replace("__TITLE__", contact.title)
    .replace("__FIRSTNAME__", contact.firstname)
    .replace("__LASTNAME__", contact.lastname)
    .replace("__TITLE__", contact.title)
    .replace("__ROLE__", contact.role)
    .replace("__TEL__", contact.telephone)
    .replace("__EMAIL__", contact.email)
    .replace("__REV__", rev)
}

#let mecard_template = "MECARD:N:__LASTNAME__,__FIRSTNAME__;TEL:__TEL__;EMAIL:__EMAIL__;;"

#let build_mecard(contact) = {
  return mecard_template
    .replace("__FIRSTNAME__", contact.firstname)
    .replace("__LASTNAME__", contact.lastname)
    .replace("__TEL__", contact.telephone)
    .replace("__EMAIL__", contact.email)
}

