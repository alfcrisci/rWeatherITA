#' get_daily_weather
#'
#' @description Retrieve meteorological data from two different source : ICAO wunderground network data or PWS by using weatherData R packages.
#' @param  idstaz  Character  Weather station ID or code for identification 
#' @param  typestaz  Character Type of data "WU-STAZ" done by ICAO code of airport,  or "WU-PWS" by id of personal weather station.
#' @param  startdate Character Initial date of period in "YYYY-MM-DD" format.
#' @param  enddate   Character Final date of period in "YYYY-MM-DD" format.
#' @return  Return   data.frame Data are returned as R data.frame object.
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords  weather, data,daily,wunderground,weatherData.
#'
#' @import weatherData
#' @export



get_daily_weather=function(typestaz="WU-STAZ",year,idstaz="LIRQ") {
  startdate=as.Date(paste0(year,"-01-01"));
  enddate=as.Date(paste0(year,"-12-31"));
  
if (typestaz == "WU-PWS") 
                       { 
  
  
                        daily <-getSummarizedWeather(idstaz, startdate,enddate, station_type = "id",opt_all_columns = TRUE)
                        
                        weather=data.frame(data=as.Date(daily$Date),
                                           max=daily$TemperatureHighC,
                                           tmed=daily$TemperatureAvgC,
                                           tmin=daily$TemperatureLowC,
                                           rhum=daily$HumidityAvg,
                                           prec=daily$PrecipitationSumCM*10)
                        return(weather)
                        }

else  (typestaz == "WU-STAZ") 
                       {
                              
                        daily <-getSummarizedWeather(idstaz, startdate,enddate,opt_all_columns = TRUE)
                        weather=data.frame(data=as.Date(daily$Date),
                                                tmax=daily$Max_TemperatureC,
                                                tmed=daily$Mean_TemperatureC,
                                                tmin=daily$Min_TemperatureC,
                                                rhum=daily$Mean_Humidity,
                                                prec=daily$Precipitationmm,
                                                press=daily$Mean_Sea_Level_PressurehPa,
                                                wind=daily$Mean_Wind_SpeedKm_h,
                                                cloud=daily$CloudCover,
                                                events=daily$Events)
                        return(daily)
                        }


}  

