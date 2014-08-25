# Template
The first heading is moved to the title in PDF export.

```python
# numpy
import numpy as np

# import sympy and configure latex output
import sympy
sympy.init_printing(use_unicode=True)
from IPython.display import Math

# import and configure matplotlib
import matplotlib as mpl
import matplotlib.pyplot as plt
%matplotlib inline
## use Scalable Vector Graphics (SVG) format for figures
## remember to employ rasterized option when plotting large
## datasets to keep figure size down
%config InlineBackend.figure_format = "svg"
## load matplotlib inline integration for base16 ipython notebook
## themes
## https://github.com/benjaminaschultz/base16-ipython-matplotlibrc
try:
    %load_ext base16_mplrc
    %base16_mplrc
except:
    pass
mpl.rcParams.update({
    'figure.dpi'        : 300,
    'savefig.dpi'       : 300,
    'grid.color'        : mpl.rcParams['xtick.color'],
})

# load ipython cython magic
%load_ext cythonmagic
```

> *[This work](http://notebooks.asorge.de) is licensed under a [Creative
Commons Attribution 4.0 International
License](http://creativecommons.org/licenses/by/4.0/).*

