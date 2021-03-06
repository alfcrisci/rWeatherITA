% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_data_TOS_cfr.r
\name{get_data_TOS_cfr}
\alias{get_data_TOS_cfr}
\title{get_data_TOS_cfr}
\usage{
get_data_TOS_cfr(id = "TOS01002085", type = "pluvio", output = "json",
  write = TRUE)
}
\arguments{
\item{id}{Weather station ID}

\item{type}{Type of data "termo" or "pluvio". Default id "pluvio".}

\item{output}{Type of file to store data a) "json" b) "csv" c) "rds". Default id "json".}

\item{write}{Type of file to store data a) "json" b) "csv" c) "rds". Default id "json".}
}
\value{
Return   xts Data are returned as xts time series object.
}
\description{
Retrieve meteorological data from CRF Centro regionale Funzionale di Monitoraggio Meteo Meteorologico of Regione Toscana.
}
\author{
Istituto di Biometeorologia Firenze Italy   \email{a.crisci@ibimet.cnr.it}.
}
\references{
Regione Toscana CRF Centro regionale Funzionale di Monitoraggio Meteo Meteorologico \email{http://www.sir.toscana.it/}
}
\keyword{data,opendata,regione}
\keyword{toscana}
\keyword{weather,}

