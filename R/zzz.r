
.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to rWeatherITA package.")
}

.onLoad <- function(libname, pkgname) {
   if(!require(GSODTools)) {devtools::install_github("environmentalinformatics-marburg/GSODTools","develop")}
  library(GSODTools)

}
