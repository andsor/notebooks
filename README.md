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

## Build

Run ``make all`` to convert markdown files into notebook files and run all
notebooks, and generate PDFs.

Run ``make clean-all`` to clean all but the ``.md`` and ``.ipynb`` sources.

## Workflow

### Writing a new notebook in markdown

1. Create a new file from the template (recommended).

```
cp src/template.md src/newnotebook.md
vi src/newnotebook.md
```

2. Write a new notebook in [your favorite editor](http://www.vim.org), possibly
   using [vim-ipython] for connecting to an [IPython] kernel to execute code in
   the editor.

3. Running ``make-all`` converts the markdown file into a notebook file with
[notedown], and runs the notebook with [runipy]. It also exports the notebook
into a PDF.

[vim-ipython]: https://github.com/ivanov/vim-ipython



