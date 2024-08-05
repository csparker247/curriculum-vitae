# curriculum-vitae

[![CI](https://github.com/csparker247/curriculum-vitae/actions/workflows/build-doc.yml/badge.svg)](https://github.com/csparker247/curriculum-vitae/actions/workflows/build-doc.yml)

CV implemented in Latex. Download the latest version: 
[[PDF]](https://csparker247.github.io/curriculum-vitae.pdf)
[[ZIP]](https://nightly.link/csparker247/curriculum-vitae/workflows/build-doc/main/PDF.zip)

## Get the source

When cloning, don't forget to get the Bib file submodule:

```shell
git clone --recurse-submodules git@github.com:csparker247/curriculum-vitae.git
```

## Build

This project is configured and built using `latexmk`. To build a PDF, simply run
that command from the root source directory:

```shell
latexmk
```

All outputs and temp files will be placed in a new subdirectory `build/`. The
final PDF can be found in `build/cv.pdf`.

### Build with make (optional)
Some of us have built-in muscle memory for running `make` whenever we want to
build a project. To help such people, this project provides a `Makefile` with
targets that run `latexmk` under various configurations:

```shell
make               # latexmk
make rebuild       # latexmk -gg
make clean         # latexmk -C
make clean-build   # latexmk -c
```
