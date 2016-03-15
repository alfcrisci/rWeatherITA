#' knots2mps
#'
#' @description Return  mps velocity from knots value.
#' 
#' @param val Numeric Velocity of wind in knots.
#' @return  Return   Numeric
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords GSOD data
#'
#'
#'
#' @export

knots2mps <- function(val, ...) {
  
  val_new <- val * 0.514444
  val_new <- round(val_new, ...)
  
  return(val_new)
}