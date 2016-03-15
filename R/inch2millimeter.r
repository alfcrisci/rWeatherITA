#' inch2millimeter
#'
#' @description Return values in millimeter from inches. Is possible to set round. Function taken from GSODtools R package \url{https://zenodo.org/record/12217#.Vugi0V5VKlM}.  
#'
#' @param val Value in inches.
#' @return  Return   Numeric value in millimeter.
#' @author  Florian Detsch
#' @keywords GSOD data
#'
#' @references  GSODtools R package \url{https://zenodo.org/record/12217#.Vugi0V5VKlM}.  
#'
#' @export

inch2millimeter <- function(val, ...) {
  
  val_new <- val * 25.4
  val_new <- round(val_new, ...)
  
  return(val_new)
}