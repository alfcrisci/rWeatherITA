
.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to rWeatherITA package.")
}

.onLoad <- function(libname, pkgname) {
   if(!require(GSODTools)) {install_github("environmentalinformatics-marburg/GSODTools")}
  library(GSODTools)

}
