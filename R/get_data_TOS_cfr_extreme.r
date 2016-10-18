get_data_TOS_cfr_extreme=function(id="TOS01002085",output="csv",write=TRUE) {
  
  download.file(paste0("http://www.sir.toscana.it/archivio/download.php?IDST=xpluvio","&IDS=",id),destfile=paste0("xpluvio_",id,".csv"))
  
  con <- file(paste0("xpluvio_",id,".csv"),open="r")
  on.exit(close(con))
  line <- readLines(con)
  file.remove(paste0("xpluvio_",id,".csv"))
  
  staz=as.character(read.table(textConnection(line[1]),sep=";")$V2)
  cod=as.character(read.table(textConnection(line[2]),sep=";")$V2)
  com=as.character(read.table(textConnection(line[3]),sep=";")$V2)
  prov=as.character(read.table(textConnection(line[4]),sep=";")$V2)
  geo=read.table(textConnection(line[5]),sep=";")
  geo=data.frame(lon=as.numeric(geo$V3),lat=as.numeric(geo$V5))
  quota=read.table(textConnection(line[7]),sep=";")
  elev=as.numeric(gsub(',','.',quota$V2))
  df_data=data.frame(staz,cod,com,prov,geo,elev)  
  
  spstaz=sp::SpatialPoints(matrix(geo,ncol=2), proj4string=CRS("+init=epsg:32632"))
  data=read.table(textConnection(line[19:length(line)]),sep=";",skip=1,na.strings =c("-9999",""))
  names(data)<-c("data","Duration","Prec")   
  data$Prec=as.numeric(gsub(",",".",data$Prec))
  data$Prec=ifelse(as.numeric(data$Prec)>1000,NA,data$Prec)
  data$year=lubridate::year(as.Date(dmy_hm(data$data)))
  levels(data$Prec)=c( "5mn","10mn","15mn","20mn","30mn","1h","3h","6h","12h","24h") 
  data_mat=with(data, tapply(Prec, list(year, Duration), mean))
  data_mat=data.frame(year=rownames(data_mat),data_mat[,c("5mn","10mn","15mn","20mn","30mn","1h","3h","6h","12h","24h")])
  rownames(data_mat)=NULL
  newdata=xts::xts( data_mat[,2:11],order=as.Date(paste0(data_mat$year,"-01-01")))  
  spstaz_geo=sp::spTransform(spstaz,CRS("+init=epsg:4326"))
  spstaz_geo=sp::SpatialPointsDataFrame(spstaz_geo,df_data)
  
  
  if (output == "json" && write==TRUE) {
     staz_df=data.frame(df_data,
                        data=data_mat)
    
    stazjson <- jsonlite::toJSON(staz_df, pretty=TRUE)
    cat(stazjson , file = file(paste0("xpluvio_",id,".json")))
    
  }
  
  if (output == "csv" && write==TRUE ) {
    write.csv(data_mat,file(paste0("xpluvio_mat_",id,".csv"),row.names=F))
  }
  
  
 
  
  res=list()
  res$data_ts=newdata
  res$data_ts=cbind(df_data,data_mat)
  res$spatial=spstaz_geo
  
  if (output == "rds"  && write==TRUE) {
     saveRDS(res,file(paste0("xpluvio_data_",id,".rds")))
  }
  
  return(res)
  
}
