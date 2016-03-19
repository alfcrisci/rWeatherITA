#' elaborateGSODfiles
#'
#' @description Extract  meteorological data from GSOD gzip files and return a data selection.  
#' @param  usaf  Character  USAF Code of file dowloaded from GSOD Global Daily SUmmary data.
#' @param  start_year Numeric  Starting year of analisys.
#' @param  end_year Numeric  Ending year of analisys.
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

elaborateGSODfiles=function(usaf,start_year = 1979, end_year = 2015,deletefile=F) {
                            temp_daily<- gzGsodStations(usaf,start_year = start_year, end_year = end_year)
                            temp_daily$Date=as.Date(ymd(temp_daily$YEARMODA))
                            temp_daily$YEARMODA=NULL
                            temp_daily$tmed <- GSODTools::toCelsius(temp_daily$TEMP, digits = 1)
                            temp_daily$tmax <- GSODTools::toCelsius(temp_daily$MAX, digits = 1)
                            temp_daily$tmin <- GSODTools::toCelsius(temp_daily$MIN, digits = 1)
                            temp_daily$prec <-inch2millimeter(temp_daily$PRCP, digits = 1)
                            temp_daily$DEWP <- GSODTools::toCelsius(temp_daily$DEWP, digits = 1)
                            temp_daily$rhum <- 100*(exp((17.625*temp_daily$DEWP)/(243.04+temp_daily$DEWP))/exp((17.625*temp_daily$tmed)/(243.04+temp_daily$tmed)))
                            temp_daily$slp=temp_daily$SLP
                            temp_daily$prec[which(temp_daily$PRCPFLAG=="I")]=NA
                            temp_daily$vmed=knots2mps(temp_daily$WDSP,1)
                            temp_daily$vmax=knots2mps(temp_daily$MXSPD,1)
                            temp_daily=temp_daily[c("Date","tmed","tmax","tmin","rhum","DEWP","vmed","vmax","prec","slp")]
if (deletefile==TRUE )
    {file.remove(Sys.glob(paste0("*",usaf,"*op.gz")))}
return(temp_daily)
}
