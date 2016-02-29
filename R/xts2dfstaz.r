#' xts2dfstaz
#'
#' @description Write and return data.frame object of xts object
#'
#' @return  Return   A data.frame of xts object.
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords data,xts
#'
#'
#'
#' @export



xts2dfstaz=function(x,name,type="pluvio") {
  data=rownames(x)
  stazdf=as.data.frame(x)
  rownames(stazdf)=NULL
  write.csv(data.frame(date=data,stazdf),file=paste0(name,"_",type,".csv"),row.names = TRUE,quote=F)
  return(data.frame(date=data,stazdf))
}
