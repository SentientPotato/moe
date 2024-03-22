#' Calculate margin of error for a proportion or difference in proportions
#'
#' The margin of error for the proportion of poll respondents giving a
#' particular answer is \deqn{z\sqrt{\frac{p(1-p)}{n}},}{z * p * (1-p) / n,}
#' where `p` is the proportion of respondents that gave the particular answer,
#' `n` is the sample size of the poll, and `z` is the corresponding quantile
#' of the standard normal distribution for the desired confidence level.
#' The margin of error for the difference between the proportions of poll
#' respondents who gave one particular answer versus another one is
#' \deqn{z\sqrt{\frac{p(1-p) + q(1-q) + 2pq}{n}},}{z * (p*(1-p) + q(1-q) + 2pq) / n,}
#' where `p` is the proportion of respondents that gave one particular answer,
#' `q` is the proportion of respondents who gave the other answer of interest,
#' `n` is the sample size of the poll, and `z` is the corresponding quantile
#' of the standard normal distribution for the desired confidence level.
#'
#' @param n How many respondents were there?
#' @param p What proportion gave the answer of interest?
#' @param q What proportion gave the other answer of interest? (Optional)
#' @param level What confidence level should be used? (Default: 0.95)
#'
#' @return An object of class "MOE"; a dataframe giving `p`, `q`,
#'     their `Difference`, the margin of error for either the difference or `p`,
#'     labeled `MOE`, the `Lower` bound of the confidence interval,
#'     the `Upper` bound of the confidence interval,
#'     `N` or the number of respondents,
#'     and `CIlevel` which is the same as `level`.
#'
#' @export
moe = function(n, p, q, level = 0.95) {
    if ( missing(q) ) {
        q = NA
        est = p
        se  = sqrt( (p * (1-p)) / n )
    } else {
        est = p - q
        se  = sqrt( ( p*(1-p) + q*(1-q) +2*p*q ) / n )
    }
    margin = qnorm(p = 0.5 + level/2) * se
    lower  = est - margin
    upper  = est + margin
    result = data.frame(
        p = p, q = q, Difference = p - q,
        MOE = margin, Lower = lower, Upper = upper,
        N = n, CIlevel = level,
        check.names = FALSE
    )
    class(result) = c("MOE", class(result))
    return(result)
}
