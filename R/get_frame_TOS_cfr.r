#' get_frame_TOS_cfr
#'
#' @description Retrieve framework data from CRF Centro regionale Funzionale di Monitoraggio Meteo Meteorologico of Regione Toscana.
#'
#' @param   query  Query to retrieve framework.
#' @return  Return  data.fame Data from http://www.sir.toscana.it/archivio/
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @references  Regione Toscana CRF Centro regionale Funzionale di Monitoraggio Meteo Meteorologico \email{http://www.sir.toscana.it/}
#' @keywords  weather, data,opendata,regione toscana
#'
#'
#'
#' @export



get_frame_TOS_cfr=function(query="json_stations") {
  
  
  frameCFRdata=fromJSON("http://www.sir.toscana.it/archivio/dati.php?D=json_stations");

  
  
  return(frameCFRdata)
  
}
