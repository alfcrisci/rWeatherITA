#' inch2millimeter
#'
#' @description Return values in millimeter from inches. Is possible to set round. Function taken from GSODtools R package \url{https://zenodo.org/record/12217#.Vugi0V5VKlM}.  
#'
#' @param val numeric: Value in inches.
#' @param decint integer: Decimal for rounding. Default is 2.
#' @return  Return   numeric Value in millimeter.
#' @author  Alfonso Crisci.
#' @keywords GSOD data
#'
#' @references  GSODtools R package \url{https://zenodo.org/record/12217#.Vugi0V5VKlM}.  
#'
#' @export

inch2millimeter <- function(val,decint=2) {
  
  val_new <- val * 25.4
  val_new <- round(val_new,decint)
  
  return(val_new)
}