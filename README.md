# typst-umit-tirol-bmim

**typst-umit-tirol-bmim** is a theme for creating exams/practicals/... in [Typst](https://github.com/typst/typst)  with the corporate design of [UMIT TIROL](https://www.umit-tirol.at/).

## Features

- **Admonitions** (with localization and plural support).
- Subset of predefined colors (see [colors.typ](colors.typ)).
- Variants:
    - exams
    - practical

## Example

See [Artifact](https://github.com/umit-iace/typst-umit-tirol-bmim-practical/actions/runs/) of last run for an example output, and
- [example/exam/main.typ](example/exam/main.typ) for the corresponding exam Typst file,
- [example/practical/main.typ](example/practical/main.typ) for the corresponding practical Typst file.

## Usage

Create a new typst project based on this template locally.

```bash
typst init @preview/typst-umit-tirol-bmim
cd typst-umit-tirol-bmim
```

Or create a project on the typst web app based on this template.

### Compile (and watch) example

```bash
typst w ./example/<variant>/main.typ --root .
```

### Compile (and watch) your typst file

```bash
typst w main.typ
```

This will watch your file and recompile it to a pdf when the file is saved.

### Install locally

- Store the package in `~/.local/share/typst/packages/local/typst-umit-tirol-bmim/0.1.0`
- Import from it with `#import "@local/typst-umit-tirol-bmim:0.1.0": *`
