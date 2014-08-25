[This work](http://github.com/andsor/notebooks) is licensed under a [Creative
Commons Attribution 4.0 International
License](http://creativecommons.org/licenses/by/4.0/).

# Confidence Intervals for Binomial Proportions

```python
import scipy.stats.distributions as dist
```

Consider a discrete random variable $X$ which indicates either "success"
($X=1$) or "failure" ($X=0$) as the outcome of a random experiment.
Such an experiment is called a *Bernoulli trial*.
The probability of success is $p=P\{X=1\}$, and the probability of failure is
$P\{X=0\}=1-p$.
Repeating a Bernoulli trial $n$ times means drawing a sample of $n$ independent
and identically distributed random variables $X_i$.
The probability mass function of observing $k$ success is the binomial
distribution

$$
\binom{n}{k} p^k (1-p)^{n-k}.
$$

The expected number of successes is $np$ with variance $np(1-p)$.
Hence, the success probability $p$ is the expected *proportion* of successes
$\frac{k}{n}$, with variance $p(1-p)/n$.

Let $\hat{p}:=\frac{k}{n}$ denote the sample proportion which is the unbiased
(and maximum likelihood) estimator for the success probability $p$, and let
$\hat{\sigma} := \hat{p}(1-\hat{p})/n$ denote the sample variance.
Then the normal $1-\alpha$ confidence interval for the binomial proportion
$\hat{p}$ is

$$
\hat{p} \pm z_{\alpha/2} \hat{\sigma},
$$

where $z_{\alpha/2}$ is the $1 - \frac{\alpha}{2}$ quantile of the standard
normal distribution.
This normal confidence interval is also called the *Wald confidence interval*.

As Cameron <cite data-cite="Cameron2011Estimation">([Cameron, 2011])</cite>
puts it, this normal approximation "suffers a *systematic* decline in
performance both for small $n$ and towards extreme values of $p$ near $0$ and
$1$, generating binomial [confidence intervals] with effective coverage far
below the desired level." (see also <cite
data-cite="Agresti1998Approximate">([Agresti & Coull, 1998])</cite> and 
<cite data-cite="DasGupta2001Interval">([DasGupta et al., 2001])</cite>)

[DasGupta et al., 2001]: http://dx.doi.org/10.1214/ss/1009213286

[Agresti & Coull, 1998]: http://dx.doi.org/10.2307/2685469

A different approach to quantifying uncertainty is Bayesian inference.
The normal (frequentist) $1 - \alpha$ confidence interval derives from a
procedure that produces $1 - \alpha$ confidence intervals that contain the true
parameter value $100(1-\alpha)\%$ of the times.
The $1-\alpha$ credible interval of Bayesian inference is the interval in which
the parameter lies with probability $1-\alpha$. 
<cite data-cite="Wasserman2004All">([Wasserman, 2004])</cite>

Specifically, Bayesian inference employes Bayes' theorem
$$
P(A|B) = \frac{P(B|A) P(A)}{P(B)}.
$$
Associate $A$ with the parameter and $B$ with the outcome from an experiment
(the data).
Then $P(A)$ is the *prior* probability of the parameter event $A$, with the
*likelihood* $P(B|A)$ of the outcome event $B$ given the parameter event $A$.
The *posterior* $P(A|B)$ is the probability of the parameter event $A$ given
the outcome event $B$.

For probability density functions, this reads
$$
f(\theta|x) = \frac{f(x|\theta) f(\theta)}{\int d\theta f(\theta|x)f(\theta)}
$$
with parameter $\theta$ and data $x$.
A Bayesian interval estimate is the $1 - \alpha$ *posterior interval* or
*credible interval* $(l,u)$ with $\int_{-\infty}^l d\theta f(\theta|x) =
\int_{u}^{+\infty} d\theta f(\theta | x) = \alpha/2$ such that $P(\theta \in
(l,u)|x) = 1 - \alpha$.

For $n$ independent Bernoulli trials with common success probability $p$, the
*likelihood* to have $k$ successes given $p$ is the binomial distribution
$$
P(k|p) = \binom{n}{k} p^k (1-p)^{n-k} \equiv B(a,b),
$$
where $B(a,b)$ is the *Beta distribution* with parameters $a = k+1$ and $b = n
- k + 1$.
Assuming a uniform prior $P(p) = 1$, the *posterior* is <cite
data-cite="Wasserman2004All">([Wasserman, 2004])</cite>
$$
P(p|k) = P(k|p)=B(a,b).
$$
A point estimate is the posterior mean
$$
\bar{p} = \frac{k+1}{n+2}
$$
with $1 - \alpha$ credible interval $(p_l, p_u)$ given by
$$
\int_0^{p_l} dp B(a,b) = \int_{p_u}^1 dp B(a,b) = \frac{\alpha}{2}.
$$

[Wasserman, 2004]: http://dx.doi.org/10.1007/978-0-387-21736-9

[Cameron, 2011]: http://dx.doi.org/10.1071/as10046
