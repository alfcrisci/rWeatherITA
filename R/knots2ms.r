
#' knots2ms
#'
#' @description Return  metertoseconds velocity from knots value.
#' 
#' 
#' @param val numeric: Value in knots.
#' @param decint integer: Decimal for rounding. Default is 2.
#' @param val  numeric Velocity of wind in meteronsecond.
#' @return  Return   numeric
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords GSOD data
#'
#'
#'
#' @export

knots2ms <- function(val, decint=2) {
  
  kmperhour = val*1.8535
  val_new = kmperhour*(1000/3600) 
  val_new <- round(val_new, decint)
  
  return(val_new)
}
