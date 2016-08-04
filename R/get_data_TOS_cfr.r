#' get_data_TOS_cfr
#'
#' @description Retrieve meteorological data from CRF Centro regionale Funzionale di Monitoraggio Meteo Meteorologico of Regione Toscana.
#'
#' @param   id  Weather station ID 
#' @param   type    Type of data "termo" or "pluvio". Default id "pluvio".
#' @param   output    Type of file to store data a) "json" b) "csv" c) "rds". Default id "json".
#' @param   write    Type of file to store data a) "json" b) "csv" c) "rds". Default id "json".
#' @return  Return   xts Data are returned as xts time series object.
#' @author  Istituto di Biometeorologia Firenze Italy   \email{a.crisci@@ibimet.cnr.it}.
#' @references  Regione Toscana CRF Centro regionale Funzionale di Monitoraggio Meteo Meteorologico \email{http://www.sir.toscana.it/}
#' @keywords  weather, data,opendata,regione toscana
#'
#' @importFrom lubridate dmy 
#' @import xts  sp 
#' @export



get_data_TOS_cfr=function(id="TOS01002085",type="pluvio",output="json",write=TRUE) {
  
  
  download.file(paste0("http://www.sir.toscana.it/archivio/download.php?IDST=",type,"&D=json","&IDS=",id),destfile=paste0(type,"_",id,".csv"))
  
  con <- file(paste0(type,"_",id,".csv"),open="r")
  on.exit(close(con))
  line <- readLines(con)
  file.remove(paste0(type,"_",id,".csv"))
  
  staz=read.table(textConnection(line[1]),sep=";")
  cod=read.table(textConnection(line[2]),sep=";")
  com=read.table(textConnection(line[3]),sep=";")
  prov=read.table(textConnection(line[4]),sep=";")
  geo=read.table(textConnection(line[5]),sep=";")
  quota=read.table(textConnection(line[7]),sep=";")
  
  spstaz=sp::SpatialPoints(matrix(c(as.numeric(geo$V3),as.numeric(geo$V5)),ncol=2), proj4string=CRS("+init=epsg:32632"))
  spstaz_geo=sp::spTransform(spstaz,CRS("+init=epsg:4326"))
  spstaz_geo=sp::SpatialPointsDataFrame(spstaz_geo,data.frame(elev=as.numeric(gsub(",",".",quota$V2))))
  data=read.table(textConnection(line[19:length(line)]),sep=";",skip=1,na.strings =c("-9999",""))
  
  
  if ( type == "pluvio") {
    names(data)<-c("data","Prec","Valid")   
    data$Prec=as.numeric(gsub(",",".",data$Prec))
    data$Prec=ifelse(as.numeric(data$Prec)>1000,NA,data$Prec)
    newdata=xts::as.xts(data.frame(prec=data$Prec,valid=data$Valid,row.names = as.Date(dmy(data$data))))  
  }
  
  if ( type == "termo") {
    names(data)<-c("data","Max","Min")   
    newdata=xts::as.xts(data.frame(tmax=data$Max,tmin=data$Min,row.names = as.Date(dmy(data$data))))  
  }
  

  if (output == "json" && write==TRUE) {
                                       staz_df=data.frame(Stazione=staz$V2,
                                                          Codice=cod$V2,
                                                          Comune=com$V2,
                                                          Provincia=prov$V2,
                                                          lat=geo$V5,
                                                          lon=geo$V3,
                                                          quota=as.numeric(gsub(",",".",quota$V2)),
                                                          proj="EPGS:3003",
                                                          data=data
                                                          )
  
                                                          stazjson <- jsonlite::toJSON(staz_df, pretty=TRUE)

                                                          cat(stazjson , file = file(paste0(type,"_",id,".json")))
  
  }
  
  if (output == "csv" && write==TRUE ) {
    
                                                          write.csv(as.data.frame(newdata),file(paste0(type,"_",id,"_df.csv")))
  }
  
  
  if (output == "rds"  && write==TRUE) {
    
                                                          saveRDS(newdata,file(paste0(type,"_",id,".rds")))
  }
  
  
  res=list()
  
  res$data=newdata
  res$location=spstaz_geo
 
 if ( type == "termo") {
                         res$cfr_data_tmax=jsonlite::fromJSON(paste0("http://www.sir.toscana.it/archivio/dati.php?IDST=termo_max&D=json&IDS=",id))
                         res$cfr_data_tmin=jsonlite::fromJSON(paste0("http://www.sir.toscana.it/archivio/dati.php?IDST=termo_min&D=json&IDS=",id))
                       }

 if ( type == "pluvio") {
                         res$cfr_data_pluvio=jsonlite::fromJSON(paste0("http://www.sir.toscana.it/archivio/dati.php?IDST=pluvio&D=json&IDS=",id))
                        }
  
  
  return(res)
  
}

