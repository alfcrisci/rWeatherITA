#' gsod_data_arrange
#'
#' @description Arrange daily GSOD data in more reliable format.
#' @param  gsod_staz  Character  Data.frame obtained with GSODToools R packages. 
#' @return  Return   data.frame Data are returned as R data.frame object.
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords  weather, data,daily,GSOD, NOAA
#'
#'
#' @export

gsod_data_arrange=function(gsod_staz) {
                                gsod_staz$Date <- as.Date(strptime(gsod_staz$YEARMODA, format = "%Y%m%d"))
                                gsod_staz$Tmed <- toCelsius(gsod_staz$TEMP, digits = 1)
                                gsod_staz$Tmax <- toCelsius(gsod_staz$MAX, digits = 1)
                                gsod_staz$Tmin <- toCelsius(gsod_staz$MIN, digits = 1)
                                gsod_staz$Prec <-inch2Millimeter(gsod_staz$PRCP, digits = 1)
                                gsod_staz$DEWP <- toCelsius(gsod_staz$DEWP, digits = 1)
                                gsod_staz$RH <- 100*(exp((17.625*gsod_staz$DEWP)/(243.04+gsod_staz$DEWP))/exp((17.625*gsod_staz$TEMP)/(243.04+gsod_staz$TEMP)))
                                gsod_staz[c("YEARMODA","Tmed","Tmax","Tmin","RH","Prec","WDSP","VISIB","SLP")]   
                                return(gsod_staz) 
                          }
