pad = function(text1, text2, side = "R") {
    n1 = nchar(text1)
    n2 = nchar(text2)
    if ( n1 > n2 ) {
        return(text1)
    }
    padding = strrep(" ", n2 - n1)
    return(ifelse(side == "R", paste0(padding, text1), paste0(text1, padding)))
}

#' @exportS3Method base::print
print.MOE = function(x, percent = TRUE, digits = 1, ...) {
    lab = ifelse(is.na(x$q), "Proportion", "Difference")
    fmt = paste0("%0.", digits, "f", ifelse(percent, "%%", ""))
    scl = ifelse(percent, 100, 1)
    est = sprintf(fmt, scl * ifelse(is.na(x$q), x$p, x$Difference))
    MOE = paste0("\U00B1", sprintf(fmt, scl * x$MOE))
    lwr = paste0("[", sprintf(fmt, scl * x$Lower), ",")
    upr = paste0(sprintf(fmt, scl * x$Upper), "]")
    CI  = paste(lwr, upr)
    CIL = paste0(100 * x$CIlevel, "% CI")
    sep = "    "
    cat(lab, pad("MOE", MOE), pad(CIL, CI), sep = sep)
    cat("\n")
    cat(pad(est, lab), pad(MOE, "MOE"), pad(CI, CIL), "\n", sep = sep)
    return(invisible(x))
}
