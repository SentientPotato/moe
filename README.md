
<!-- README.md is generated from README.Rmd. Please edit that file -->

# moe

<!-- badges: start -->
<!-- badges: end -->

`{moe}` helps you calculate margins of error for poll questions.

## Installation

You can install the development version of moe from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("SentientPotato/moe")
```

## Example

Suppose you had a poll with 1,510 respondents, where 44% said they’d
vote for Joe Biden for US President in November 2024, while 43% said
they’d vote for Donald Trump (like [this Economist/YouGov
poll](https://tinyurl.com/2z49d8cf)). We can calculate the margin of
error on each of those answers:

``` r
library(moe)
moe(n = 1510, p = 0.44) ## MOE & CI for % voting Biden
#> Proportion      MOE            95% CI
#>      44.0%    ±2.5%    [41.5%, 46.5%]
moe(n = 1510, p = 0.43) ## MOE & CI for % voting Trump
#> Proportion      MOE            95% CI
#>      43.0%    ±2.5%    [40.5%, 45.5%]
```

However, we are probably more interested in the margin of error on their
*difference*, or in other words, how far ahead or behind Biden is.
Importantly, the margin of error on Biden’s (or Trump’s) lead will be
bigger than the margin of error on the proportion saying they’d vote for
him (see the [Mathematical Details](#mathematical-details) section for
details); in fact, it will likely be roughly **twice** as large! So if
what you want to know is the confidence interval on a lead, simply
supply the proportion supporting each option:

``` r
moe(n = 1510, p = 0.44, q = 0.43) ## MOE & CI for the difference
#> Difference      MOE           95% CI
#>       1.0%    ±4.7%    [-3.7%, 5.7%]
```

So for this poll, we find out Biden’s level of support, 44%, has a
margin of error of ±2.5% for a 95% confidence interval of \[41.5%,
46.5%\], but Biden’s lead over Trump of 1% (44% - 43%) has a larger
margin of error of 4.7% for a 95% confidence interval of \[-3.7%,
5.7%\].

## Mathematical Details

A $\gamma$% **confidence interval** (CI) is an interval around an
estimate such that the true parameter value will be contained in the CI
$\gamma$% of the time. The **margin of error** (MOE) is one half the
width of the CI; the general formula for MOE is

``` math
\text{MOE}_\gamma = z_\gamma \sqrt{\frac{\sigma^2}{n}},
```

where $z_\gamma$ is the $\gamma$ quantile (typically of a standard
normal), $\sigma$ is the *population* standard deviation, and $n$ is the
number of observations.

For proportions, $\sigma^2 = p(1-p)$, so the MOE is straightforwardly

``` math
\text{MOE}_\gamma\left(p\right) = z_\gamma \sqrt{\frac{p(1-p)}{n}}.
```

However, sometimes we care more about the MOE for a difference in
proportions. Since
$\text{Var}\left[X - Y\right] = \text{Var}\left[X\right] + \text{Var}\left[Y\right] - 2\text{Cov}\left[X, Y\right]$,

``` math
\text{MOE}_\gamma\left(p-q\right) = z_\gamma \sqrt{\frac{p(1-p) + q(1-q) + 2pq}{n}}.
```
