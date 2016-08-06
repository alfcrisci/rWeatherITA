#' knots2mps
#'
#' @description Return  mps velocity from knots value.
#'
#' @param val numeric: Value in inches.
#' @param digits integer: Decimal for rounding. Default is 2.
#' @param val numeric Velocity of wind in knots.
#' @return  Return   Numeric value in meterOnsecond.
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords GSOD data
#'
#'
#'
#' @export

knots2mps <- function(val, digits=2) {
  
  val_new <- val * 0.514444
  val_new <- round(val_new, digits)
  
  return(val_new)
}
