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

Run ``make all-auto`` to run ``make all`` automatically every second.

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

