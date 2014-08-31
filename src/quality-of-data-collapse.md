# The Quality of Finite-Size Data Collapse

# Finite-size scaling

The finite-size scaling ansatz 

$$
A_L(\varrho) = L^{\zeta/\nu} \tilde{f}\left(L^{1/\nu} (\varrho - \varrho_c)
\right)
$$

postulates how a physical quantity $A_L(\varrho)$ observed in a system of
finite size scales with system size $L$ and paramater $\varrho$ according to a
scaling function $\tilde{f}$, the critical parameter $\varrho_c$, the
critical exponent $\zeta$ of the quantity itself, and the critical exponent
$\nu$ of the correlation length $\xi$ 
<cite data-cite="Newman1999Monte">([Newman & Barkema, 1999])</cite>, 
<cite data-cite="Binder2010Monte">([Binder & Heermann, 2010])</cite>.

[Binder & Heermann, 2010]: http://dx.doi.org/10.1007/978-3-642-03163-2

Finite-size scaling analysis concerns experimental data $a_{L_i, \varrho_j}$ at
system sizes $L_i$ and parameter values $\varrho_j$.
Plotting $L_i^{-\zeta/\nu} a_{L_i, \varrho_j}$ against $L_i^{1/nu} (\varrho -
\varrho_c)$ with the right choice of $\varrho_c, \nu, \zeta$ should let the
data collapse onto a single curve.
The single curve of course is the scaling function $\tilde{f}$ from the
finite-size scaling ansatz.
In the following, we present a measure by Houdayer & Hartmann 
<cite data-cite="Houdayer2004Lowtemperature">([Houdayer & Hartmann, 2004])</cite>
for the quality of the data collapse.

[Houdayer & Hartmann, 2004]: http://dx.doi.org/10.1103/physrevb.70.014418 

# The quality function

Houdayer & Hartmann <cite data-cite="Houdayer2004Lowtemperature">([Houdayer &
Hartmann, 2004])</cite> refine a method proposed by Kawashima & Ito 
<cite data-cite="Kawashima1993Critical">([Kawashima & Ito, 1993])</cite>.
They define the quality as the reduced $\chi^2$ statistic

\begin{equation}
S = \frac{1}{\mathcal{N}} \sum_{i,j} \frac{(y_{ij} -
Y_{ij})^2}{dy_{ij}^2+dY_{ij}^2},
\end{equation}

where the values $y_{ij}, dy_{ij}$ are the scaled observations and its standard
errors at $x_{ij}$, and the values $Y_{ij}, dY_{ij}$ are the estimated value of
the master curve and its standard error at $x_{ij}$.

[Kawashima & Ito, 1993]: http://dx.doi.org/10.1143/jpsj.62.435

The quality $S$ is the mean square of the weighted deviations from the master
curve.
As we expect the individual deviations $y_{ij} - Y_{ij}$ to be of the order of
the individual error $\sqrt{dy_{ij}^2 + dY_{ij}^2}$ for an optimal fit, the
quality $S$ should attain its minimum $S_{\min}$ at around $1$ and be much
larger otherwise <cite data-cite="Bevington2003Data">([Bevington & Robinson,
2003])</cite>.

Let $i$ enumerate the system sizes $L_i$, $i = 1, \ldots, k$ and let $j$
enumerate the parameters $\varrho_j$, $j = 1, \ldots, n$ with $\varrho_1 <
\varrho_2 < \ldots < \varrho_n$.
The scaled data are

\begin{align}
y_{ij} & := L_i^{-\zeta/\nu} a_{L_i, \varrho_j} \\
dy_{ij} & := L_i^{-\zeta/\nu} da_{L_i, \varrho_j} \\
x_{ij}  & := L_i^{1/\nu}(\varrho - \varrho_c).
\end{align}

The sum in the quality function $S$ only involves terms for which the estimated
value $Y_{ij}$ of the master curve at $x_{ij}$ is defined. The number of such
terms is $\mathcal{N}$.

The master curve itself depends on the scaled data. For a given $i$, $L_i$, we
estimate the master curve at $x_{ij}$ by the two respective data from all the
other system sizes which respectively enclose $x_{ij}$:
for each $i \neq i$, let $j'$ be such that $x_{i'j'} \leq x_{ij} \leq
x_{i'(j'+1)}$, and select the points $(x_{i'j'}, y_{i'j'}, dy_{i'j'}),
(x_{i'(j'+1)}, y_{i'(j'+1)}, dy_{i'(j'+1)})$.
Do not select points for some $i'$, if there is no such $j'$. If there is no
such $j'$ for all $i'$, the master curve remains undefined at $x_{ij}$.

Given the selected points $(x_l, y_l, dy_l)$, the local approximation of the
master curve is the linear fit

$$
y = mx + b
$$

with weighted least squares <cite data-cite="Strutz2011Data">(Strutz,
2011)</cite>.
The weights $w_l$ are the reciprocal variances, $w_l := 1/dy_{ij}^2$.
The estimates and (co)variances of the slope $m$ and intercept $b$ are

\begin{align*}
\hat{b} &= \frac{1}{\Delta} (K_{xx}K_y - K_xK_{xy}) \\
\hat{m} &= \frac{1}{\Delta} (K K_{xy} - K_x K_y)
\end{align*}

$$
\hat{\sigma}_b^2 = \frac{K_{xx}}{\Delta} , \hat{\sigma}_m^2 = \frac{K}{\Delta},
\hat{\sigma}_{bm} = - \frac{K_x}{\Delta}
$$

with $K_{nm} := \sum w_l x_l^n y_l^m$, $K := K_{00}$, $K_x := K_{10}$, $K_y :=
K_{01}$, $K_{xx} := K_{20}$, $K_{xy} := K_{11}$, $\Delta := KK_{xx} - K_x^2$.

Hence, the estimated value of the master curve at $x_{ij}$ is

$$
Y_{ij} = \hat{m} x_{ij} + \hat{b}
$$

with error propagation

$$
dY_{ij}^2 = \hat{\sigma}^2 x_{ij}^2 + 2 \hat{\sigma}_{bm} x_{ij} +
\hat{\sigma}_b^2.
$$

> *[This work](http://notebooks.asorge.de) is licensed under a [Creative
Commons Attribution 4.0 International
License](http://creativecommons.org/licenses/by/4.0/).*

