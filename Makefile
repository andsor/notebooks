notebook_markdown = $(filter-out README.md,$(wildcard *.md))
notebooks_md = $(notebook_markdown:.md=.ipynb)
notebooks_ipynb = $(wildcard *.ipynb)
notebooks = $(notebooks_md) $(notebooks_ipynb)
notebook_tex_exports = $(notebooks:.ipynb=.tex)
notebook_pdf_exports = $(notebooks:.ipynb=.pdf)
notebook_export_dirs = $(notebooks:.ipynb=_files)

bibfile = notebooks.bib
citeulike_cookies = citeulike-cookies.wget
citeulike_group = 19049

all: $(notebook_pdf_exports)
all-ipynb: $(notebooks_md)

%.ipynb : %.md
	notedown "$<" > "$@"
	runipy -o "$@"

%.pdf : %.ipynb $(bibfile)
	ipython nbconvert --to latex --template notebooks.tplx \
	--post PDF "$<"

.PHONY: bib clean clean-all

bib:    
	wget -O $(bibfile) \
	"http://www.citeulike.org/bibtex/group/$(citeulike_group)?incl_amazon=0&key_type=4"

clean: clean-tex-exports clean-export-dirs

clean-all: clean-tex-exports clean-notebooks clean-pdf-exports clean-export-dirs

clean-notebooks:
	-rm -Rf $(notebooks_md)

clean-tex-exports:
	-rm -Rf $(notebook_tex_exports)

clean-pdf-exports: clean-export-dirs
	-rm -Rf $(notebook_pdf_exports)

clean-export-dirs:
	-rm -Rf $(notebook_export_dirs)

