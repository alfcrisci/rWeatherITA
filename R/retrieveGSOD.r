#' retrieveGSOD
#'
#' @description Download meteorological data from GSOD as  gzip files form.
#'   
#' @param  usaf  character  USAF code of GSOD Global Summary of Daily climatic data.
#' @param  WBAN  character  Another string for file naming.
#' @param  start_year  numeric Starting Year of data retrieval.
#' @param  end_year  numeric  Ending Year of data retrieval.
#' @param  dsn  character  Path of retrieved data
#' @return  Return   data.frame Data are returned as R data.frame object.
#' @author  Istituto di Biometeorologia Firenze Italy  Alfonso crisci \email{a.crisci@@ibimet.cnr.it}.
#' @keywords  weather data, daily value , GSOD.
#'
#' @export
#' 
#' 
#' 
#' 
retrieveGSOD=function(usaf,WBAN="99999",start_year = NA, end_year = NA, dsn = ".",myusername="",mypassword="") 
{
  
  fls_gz <- sapply(start_year:end_year, function(year) {
    dlbase <- paste0(as.character(usaf), "-", WBAN, "-", year, ".op.gz")
    dlurl <- paste0("ftp://ftp.ncdc.noaa.gov/pub/data/gsod/",year, "/", dlbase)
    dlfile <- paste0(dsn, "/", dlbase)
    
    if (file.exists(dlfile)) {
      cat("File", dlfile, "already exists. Proceeding to next file... \n")
    }
    else {
          try(R.utils::downloadFile(dlurl, dlfile, username = myusername, password =mypassword))
    }
    return(dlfile)  })
  
}
