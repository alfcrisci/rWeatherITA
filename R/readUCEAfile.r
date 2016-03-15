#' readUCEAfile
#'
#' @description Extract  meteorological data from UCEA \url{http://cma.entecra.it/Banca_dati_agrometeo/} gzip daily data file.  
#' @param  file  Character  Name of file dowloaded from http://cma.entecra.it/Banca_dati_agrometeo/index3.htm
#' @param  param Character Type of name of parameter defined at http://cma.entecra.it/Banca_dati_agrometeo/miekal100_elepara_3.htm
#' @return  Return   data.frame Data are returned as R data.frame object.
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords  weather, data,daily,UCEA
#'
#' @import R.utils
#' @import lubridate
#' @export


readUCEAfile=function(file,param="TEMPARIA2M_MAXG") {
  x=gunzip(file);
  a=readLines(x);
  len=length(a)
  dataday=read.table(textConnection(a[1]),stringsAsFactors = FALSE)
  dataday=as.Date(lubridate::dmy(as.character(dataday[3:length(dataday)])))
  dataelems=list()
  datastation=list()
  j=1
  for ( i in 2:length(a)) {
    temp=read.table(textConnection(a[i]),stringsAsFactors = FALSE)
    if ( which(temp==param) ==2)
    {datastation[[j]]=paste(temp[1])}
    else {datastation[[j]]=paste(temp[1],temp[2])}
    
    temp=temp[(which(temp==param)+1):length(temp)]
    temp=gsub(",",".",temp)
    temp=gsub("--",NA,temp)
    dataelems[[j]]=as.numeric(temp)
    j=j+1
  }
  res=data.frame(dates=dataday,do.call('cbind',dataelems))
  names(res)[2:ncol(res)]=gsub(" ","_",unlist(datastation))
  return(res)
  
}          
