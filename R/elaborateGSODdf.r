#' elaborateGSODdf
#'
#' @description Elaborate meteorological data from GSOD data.frames and return a data selection.  
#' @param  temp_daily  Data.frame  Original raw data  file  from GSOD Global Daily SUmmary data.
#' @return  Return   data.frame Data are returned as R data.frame object.
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords  weather data,daily value , GSOD.
#'
#' @import lubridate
#' @export
#' 
#' 
#' 
#' 
#'

elaborateGSODdf=function(temp_daily) {
   temp_daily$Date=as.Date(ymd(temp_daily$YEARMODA))
  temp_daily$YEARMODA=NULL
  temp_daily$tmed <- GSODtools::toCelsius(temp_daily$TEMP, digits = 1)
  temp_daily$tmax <- GSODtools::toCelsius(temp_daily$MAX, digits = 1)
  temp_daily$tmin <- GSODtools::toCelsius(temp_daily$MIN, digits = 1)
  temp_daily$prec <-inch2Millimeter(temp_daily$PRCP, digits = 1)
  temp_daily$DEWP <- GSODtools::toCelsius(temp_daily$DEWP, digits = 1)
  temp_daily$rhum <- 100*(exp((17.625*temp_daily$DEWP)/(243.04+temp_daily$DEWP))/exp((17.625*temp_daily$tmed)/(243.04+temp_daily$tmed)))
  temp_daily$slp=temp_daily$SLP
  temp_daily$prec[which(temp_daily$PRCPFLAG=="I")]=NA
  temp_daily$vmed=knots2mps(temp_daily$WDSP,1)
  temp_daily$vmax=knots2mps(temp_daily$MXSPD,1)
  temp_daily=temp_daily[c("Date","tmed","tmax","tmin","rhum","DEWP","vmed","vmax","prec","slp")]
  return(temp_daily)
}