notebooks
=========

IPython notebooks

## Requires

 * [IPython]
 * [notedown]
 * [runipy]

[notedown]: https://github.com/aaren/notedown
[runipy]: https://pypi.python.org/pypi/runipy
[IPython]: http://ipython.org/notebook

## Sources

Either put a markdown file (``.md``) in ``src/``, or a notebook file
(``.ipynb``) in ``notebooks/``.

Note that the first heading will get transformed into the title during
LaTeX/PDF export.

## Build

Run ``make all`` to convert markdown files into notebook files and run all
notebooks, and generate PDFs.

Run ``make clean-all`` to clean all but the ``.md`` and ``.ipynb`` sources.

Run ``make all-auto`` to run ``make all`` automatically every second.

## Citations

See the [Tutorial on Managing citations in the IPython
Notebook](http://nbviewer.ipython.org/github/ipython/nbconvert-examples/blob/master/citations/Tutorial.ipynb)
for inserting citations into a notebook.

### Bibliography

A [CiteULike group](http://www.citeulike.org/group/19049) organizes all
references. Run ``make bib`` to download the [BibTeX file] directly.

**NOTE:** You need to update the BibTeX file explicitly. It will not update
when running just ``make``.

[BibTeX file]: notebooks.bib

### Bibliography style

The bibliography style is [REVTeX]. The [nbconvert template](notebooks.tplx)
implements it according to http://tex.stackexchange.com/a/15691/30438

[REVTeX]: http://journals.aps.org/revtex/

## Workflow

### Writing a new notebook in markdown

* Create a new file from the template (recommended).

```
cp src/template.md src/newnotebook.md
vi src/newnotebook.md
```

* Write a new notebook in [your favorite editor](http://www.vim.org), possibly
   using [vim-ipython] for connecting to an [IPython] kernel to execute code in
   the editor.

* Running ``make-all`` converts the markdown file into a notebook file with
[notedown], and runs the notebook with [runipy]. It also exports the notebook
into a PDF.

[vim-ipython]: https://github.com/ivanov/vim-ipython

### Editing an existing notebook

You may also create a new notebook in the ``notebooks/`` folder, or copy an
existing notebook here.

**CAUTION**: ``make`` will overwrite and/or delete any ``.ipynb`` file in the
``notebooks/`` directory if there is a corresponding ``.md`` file in the
``src/`` directory. Thus, **always rename a notebook file generated from
markdown before editing!**

## License

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">notebooks</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://notebooks.asorge.de" property="cc:attributionName" rel="cc:attributionURL">Andreas Sorge</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
