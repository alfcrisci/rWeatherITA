#' xts2dfstaz
#'
#' @description Write and return data.frame object of xts object
#'
#' @param x xts object
#' @param csvwrite logical write a csv file.
#' 
#' @return  Return   a data.frame of xts object.
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords data, xts
#'
#'
#'
#' @export



xts2dfstaz=function(x,csvwrite=FALSE) {
  data=rownames(x)
  stazdf=as.data.frame(x)
  rownames(stazdf)=NULL
  if (csvwrite==T) {write.csv(data.frame(date=data,stazdf),file=paste0(name,"_",type,".csv"),row.names = TRUE,quote=F)}
  return(data.frame(date=data,stazdf))
}
