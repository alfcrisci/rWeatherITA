#' appendList
#'
#' @description Utility function to append element to a list.
#'
#' @return  Return   A data.frame of xts object.
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords  weather, data,opendata,regione toscana
#'
#'
#'
#' @export



appendlist <- function (x, val) 
{
  stopifnot(is.list(x), is.list(val))
  xnames <- names(x)
  for (v in names(val)) {
    x[[v]] <- if (v %in% xnames && is.list(x[[v]]) && is.list(val[[v]])) 
      appendList(x[[v]], val[[v]])
    else c(x[[v]], val[[v]])
  }
  x
}
