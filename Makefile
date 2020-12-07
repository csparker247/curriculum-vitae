all:
	@latexmk

rebuild:
	@latexmk -gg

clean:
	@latexmk -C

clean-build:
	@latexmk -c
