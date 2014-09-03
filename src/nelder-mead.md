# The Nelder--Mead algorithm

The Nelder--Mead algorithm 
<cite data-cite="Nelder1965Simplex">([Nelder & Mead, 1965])</cite>
attempts to minimize a goal function $f : \mathbb{R}^n \to \mathbb{R}$ of an
unconstrained optimization problem.
As it only evaluates function values, but no derivatives, the Nelder--Mead
algorithm is a *direct search method* 
<cite data-cite="Kolda2003Optimization">([Kolda et al., 2003])</cite>.
Although the method generally lacks rigorous convergence properties 
<cite data-cite="Lagarias1998Convergence">([Lagarias et al., 1998])</cite> 
<cite data-cite="Price2002Convergent">([Price et al., 2002])</cite>, in
practice the first few iterations often yield satisfactory results <cite
data-cite="Singer2009NelderMead">([Singer & Mead, 2009])</cite>.
Typically, each iteration evaluates the goal function only once or twice 
<cite data-cite="Singer2004Efficient">([Singer & Singer, 2004])</cite>,
which is why the Nelder--Mead algorithm is comparatively fast if goal function
evaluation is the computational bottleneck 
<cite data-cite="Singer2009NelderMead">([Singer & Mead, 2009])</cite>.

# The algorithm
Nelder & Mead <cite data-cite="Nelder1965Simplex">([Nelder & Mead,
1965])</cite> refined a simplex method by Spendley et al. 
<cite data-cite="Spendley1962Sequential">([Spendley et al., 1962])</cite>.
A simplex is the generalization of triangles in $\mathbb{R}^2$ to $n$
dimensions: in $\mathbb{R}^n$, a simplex is the convex hull of $n+1$ vertices
$x_0, \ldots, x_n \in \mathbb{R}^n$.
Starting with an initial simplex, the algorithm attempts to decrease the
function values $f_i := f(x_i)$ at the vertices by a sequence of elementary
transformations of the simplex along the local landscape.
The algorithm *succeeds* when the simplex is sufficiently small (*domain
convergence test*), and/or when the function values $f_i$ are sufficiently close
(*function-value convergence test*).
The algorithm *fails* when it did not succeed after a given number of
iterations or function evaluations.
See Singer & Nead <cite data-cite="Singer2009NelderMead">([Singer & Mead,
2009])</cite> and references therein for a complete description of the
algorithm and the simplex transformations.

# Uncertainties in parameter estimation

For parameter estimation, Spendley et al. <cite
data-cite="Spendley1962Sequential">([Spendley et al., 1962])</cite> and Nelder
& Mead <cite data-cite="Nelder1965Simplex">([Nelder & Mead,
1965])</cite> provide a method to estimate the uncertainties.
Fitting a quadratic surface to the vertices and the midpoints of the edges of
the final simplex yields an estimate for the variance--covariance matrix.
The variance--covariance matrix is $\mathbf{Q} \mathbf{B}^{-1} \mathbf{Q}^T$ as
originally given by Nelder & Mead <cite data-cite="Nelder1965Simplex">([Nelder
& Mead, 1965])</cite>, despite the erratum on the original paper.
The errors are the square roots of the diagonal terms 
<cite data-cite="Bevington2003Data">([Bevington & Robinson, 2003])</cite>.

# Implementation

Scientific Python 
<cite data-cite="Jones2001SciPy">([Jones et al., 2001])</cite> 
<cite data-cite="Oliphant2007Python">([Oliphant, 2007])</cite>
implements the Nelder--Mead method for the [scipy.optimize.minimize]
function.
Note that this implementation only returns the vertex with the lowest function
value, but not the whole final simplex.

[scipy.optimize.minimize]: http://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.minimize.html

[Oliphant, 2007]: http://dx.doi.org/10.1109/mcse.2007.58

[Jones et al., 2001]: http://www.scipy.org

[Spendley et al., 1962]: http://dx.doi.org/10.1080/00401706.1962.10490033

[Singer & Mead, 2009]: http://dx.doi.org/10.4249/scholarpedia.2928

[Singer & Singer, 2004]: http://dx.doi.org/10.1002/anac.200410015

[Price et al., 2002]: http://dx.doi.org/10.1023/a%3a1014849028575

[Lagarias et al., 1998]: http://dx.doi.org/10.1137/s1052623496303470

[Kolda et al., 2003]: http://dx.doi.org/10.1137/s003614450242889

[Nelder & Mead, 1965]: http://dx.doi.org/10.1093/comjnl/7.4.308

```python
# ******NOTICE***************
# optimize.py module by Travis E. Oliphant
#
# You may copy and use this module as you see fit with no
# guarantee implied provided you keep this notice in all copies.
# *****END NOTICE************

# numpy
import numpy
import scipy.optimize

from numpy import (
    asfarray
)

from scipy.optimize.optimize import (
    _check_unknown_options, wrap_function, _status_message, OptimizeResult
)


def _neldermead_errors(
    sim, fsim, func
):
    # fit quadratic coefficients
    fun = func

    n = len(sim) - 1

    x = 0.5 * (sim[numpy.mgrid[0:6, 0:6]][1] + sim[numpy.mgrid[0:6, 0:6]][0])

    for i in range(n + 1):
        assert(numpy.array_equal(x[i,i], sim[i]))
        for j in range(n + 1):
            assert(numpy.array_equal(x[i,j], 0.5 * (sim[i] + sim[j])))

    y = numpy.nan * numpy.ones(shape=(n + 1, n + 1))
    for i in range(n + 1):
        y[i, i] = fsim[i]
        for j in range(i + 1, n + 1):
            y[i, j] = y[j, i] = fun(x[i, j])

    y0i = y[numpy.mgrid[0:6, 0:6]][0][1:,1:, 0]
    for i in range(n):
        for j in range(n):
            assert y0i[i, j] == y[0, i + 1], (i, j)

    y0j = y[numpy.mgrid[0:6, 0:6]][0][0, 1:, 1:]
    for i in range(n):
        for j in range(n):
            assert y0j[i, j] == y[0, j + 1], (i, j)

    b = 2 * (y[1:, 1:] + y[0, 0] - y0i - y0j)
    for i in range(n):
        assert abs(b[i, i] - 2 * (fsim[i + 1] + fsim[0] - 2 * y[0, i + 1])) < 1e-12
        for j in range(n):
            if i == j:
                continue
            assert abs(b[i, j] - 2 * (y[i + 1, j + 1] + fsim[0] - y[0, i + 1] -
                y[0, j + 1])) < 1e-12

    q = (sim - sim[0])[1:].T
    for i in range(n):
        assert numpy.array_equal(q[:, i], sim[i + 1] - sim[0])
    
    varco = numpy.dot(q, numpy.dot(numpy.linalg.inv(b), q.T))
    return numpy.sqrt(numpy.diag(varco))

def minimize_neldermead_witherrors(
    fun, x0, args=(), callback=None,
    xtol=1e-4, ftol=1e-4, maxiter=None, maxfev=None,
    disp=False, return_all=False, with_errors=True,
    **unknown_options):
    """
    Minimization of scalar function of one or more variables using the
    Nelder-Mead algorithm.

    Options for the Nelder-Mead algorithm are:
        disp : bool
            Set to True to print convergence messages.
        xtol : float
            Relative error in solution `xopt` acceptable for convergence.
        ftol : float
            Relative error in ``fun(xopt)`` acceptable for convergence.
        maxiter : int
            Maximum number of iterations to perform.
        maxfev : int
            Maximum number of function evaluations to make.

    This function is called by the `minimize` function with
    `method=minimize_neldermead_with_errors`. It is not supposed to be called directly.
    """
    maxfun = maxfev
    retall = return_all

    fcalls, func = wrap_function(fun, args)
    x0 = asfarray(x0).flatten()
    N = len(x0)
    rank = len(x0.shape)
    if not -1 < rank < 2:
        raise ValueError("Initial guess must be a scalar or rank-1 sequence.")
    if maxiter is None:
        maxiter = N * 200
    if maxfun is None:
        maxfun = N * 200

    rho = 1
    chi = 2
    psi = 0.5
    sigma = 0.5
    one2np1 = list(range(1, N + 1))

    if rank == 0:
        sim = numpy.zeros((N + 1,), dtype=x0.dtype)
    else:
        sim = numpy.zeros((N + 1, N), dtype=x0.dtype)
    fsim = numpy.zeros((N + 1,), float)
    sim[0] = x0
    if retall:
        allvecs = [sim[0]]
    fsim[0] = func(x0)
    nonzdelt = 0.05
    zdelt = 0.00025
    for k in range(0, N):
        y = numpy.array(x0, copy=True)
        if y[k] != 0:
            y[k] = (1 + nonzdelt)*y[k]
        else:
            y[k] = zdelt

        sim[k + 1] = y
        f = func(y)
        fsim[k + 1] = f

    ind = numpy.argsort(fsim)
    fsim = numpy.take(fsim, ind, 0)
    # sort so sim[0,:] has the lowest function value
    sim = numpy.take(sim, ind, 0)

    iterations = 1

    while (fcalls[0] < maxfun and iterations < maxiter):
        if (numpy.max(numpy.ravel(numpy.abs(sim[1:] - sim[0]))) <= xtol and
                numpy.max(numpy.abs(fsim[0] - fsim[1:])) <= ftol):
            break

        xbar = numpy.add.reduce(sim[:-1], 0) / N
        xr = (1 + rho) * xbar - rho * sim[-1]
        fxr = func(xr)
        doshrink = 0

        if fxr < fsim[0]:
            xe = (1 + rho * chi) * xbar - rho * chi * sim[-1]
            fxe = func(xe)

            if fxe < fxr:
                sim[-1] = xe
                fsim[-1] = fxe
            else:
                sim[-1] = xr
                fsim[-1] = fxr
        else:  # fsim[0] <= fxr
            if fxr < fsim[-2]:
                sim[-1] = xr
                fsim[-1] = fxr
            else:  # fxr >= fsim[-2]
                # Perform contraction
                if fxr < fsim[-1]:
                    xc = (1 + psi * rho) * xbar - psi * rho * sim[-1]
                    fxc = func(xc)

                    if fxc <= fxr:
                        sim[-1] = xc
                        fsim[-1] = fxc
                    else:
                        doshrink = 1
                else:
                    # Perform an inside contraction
                    xcc = (1 - psi) * xbar + psi * sim[-1]
                    fxcc = func(xcc)

                    if fxcc < fsim[-1]:
                        sim[-1] = xcc
                        fsim[-1] = fxcc
                    else:
                        doshrink = 1

                if doshrink:
                    for j in one2np1:
                        sim[j] = sim[0] + sigma * (sim[j] - sim[0])
                        fsim[j] = func(sim[j])

        ind = numpy.argsort(fsim)
        sim = numpy.take(sim, ind, 0)
        fsim = numpy.take(fsim, ind, 0)
        if callback is not None:
            callback(sim[0])
        iterations += 1
        if retall:
            allvecs.append(sim[0])

    x = sim[0]
    fval = numpy.min(fsim)
    warnflag = 0
    errors = None

    if fcalls[0] >= maxfun:
        warnflag = 1
        msg = _status_message['maxfev']
        if disp:
            print('Warning: ' + msg)
    elif iterations >= maxiter:
        warnflag = 2
        msg = _status_message['maxiter']
        if disp:
            print('Warning: ' + msg)
    else:
        msg = _status_message['success']
        errors = _neldermead_errors(sim, fsim, func)       
        if disp:
            print(msg)
            print("         Current function value: %f" % fval)
            print("         Iterations: %d" % iterations)
            print("         Function evaluations: %d" % fcalls[0])

    result = OptimizeResult(fun=fval, nit=iterations, nfev=fcalls[0],
                            status=warnflag, success=(warnflag == 0),
			    message=msg, x=x, errors=errors, sim=sim,
                            fsim=fsim)

    if retall:
        result['allvecs'] = allvecs
    return result

x0 = [1.3, 0.7, 0.8, 1.9, 1.2]
res = scipy.optimize.minimize(scipy.optimize.rosen, x0, method='Nelder-Mead')
print(res)

res_witherrors = scipy.optimize.minimize(
    scipy.optimize.rosen,
    x0,
    method=minimize_neldermead_witherrors
)
print(res_witherrors)
```

> *[This work](http://notebooks.asorge.de) is licensed under a [Creative
Commons Attribution 4.0 International
License](http://creativecommons.org/licenses/by/4.0/).*

