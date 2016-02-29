
.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to rWeatherITA package.")
}

.onLoad <- function(libname, pkgname) {
require(GSODTools)

}
