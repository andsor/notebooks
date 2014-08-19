# Hello, world!

This is our hello world notebook!

```python
print("Hello world!")
```

Here we continue with some formula

\begin{align}
f(x) = \sin(\pi x),
\end{align}

which we would like to plot

```python
%matplotlib inline
import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
```


```python
x = np.linspace(0., 2.) 
plt.plot(x, np.sin(np.pi * x))
plt.show()
```

This is the end of the file.

