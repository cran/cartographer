## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(cartographer)

## -----------------------------------------------------------------------------
# in R/zzz.R
.onLoad <- function(libname, pkgname) {
   cartographer::register_map(
     "my_package.uk",
     data = rnaturalearth::ne_states(country = "united kingdom", returnclass = "sf"),
     feature_column = "name_en",
     outline = rnaturalearth::ne_countries(country = "united kingdom", returnclass = "sf", scale = "large")
   )
}

## ---- eval=FALSE--------------------------------------------------------------
#  # Preserve the original coordinate reference system.
#  crs_orig <- sf::st_crs(high_res_sf_data_frame)
#  
#  # Convert to a more suitable CRS for manipulation. Note that the lat_ts argument
#  # here is the "latitude of true scale", i.e. the latitude at which scale will be
#  # the least distorted. Adjust this based on your data.
#  crs_working <- sf::st_crs("+proj=eqc +lat_ts=34 units=m")
#  
#  # Choose a resolution: features smaller than this scale will be lost.
#  tolerance_m <- 1000L
#  
#  low_res <- high_res_sf_data_frame |>
#    sf::st_transform(crs_working) |>
#    sf::st_simplify(dTolerance = tolerance_m) |>
#    sf::st_transform(crs_orig)
#  
#  # Compare the size after reducing the resolution:
#  object.size(high_res_sf_data_frame)
#  object.size(low_res)

## ---- eval=FALSE--------------------------------------------------------------
#  new_geom <- geom |>
#    sf::st_transform(crs_working) |>
#    sf::st_union() |>
#    nngeo::st_remove_holes() |>
#    sf::st_make_valid()

