
#' knots2ms
#'
#' @description Return  metertoseconds velocity from knots value.
#' 
#' @param val  Numeric Velocity of wind in metertosecond.
#' @return  Return   Numeric
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords GSOD data
#'
#'
#'
#' @export

knots2ms <- function(val, ...) {
  
  kmperhour = val*1.8535
  val_new = kmperhour*(1000/3600) 
  val_new <- round(val_new, ...)
  
  return(val_new)
}
