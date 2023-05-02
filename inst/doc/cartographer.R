## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(cartographer)

# list registered datasets
feature_types()

# list feature names in one of the datasets
head(feature_names("sf.nc"))

## -----------------------------------------------------------------------------
head(nc_type_example_1)

## ---- error = TRUE------------------------------------------------------------
add_geometry(nc_type_example_1, county, feature_type = "sf.nc")

## -----------------------------------------------------------------------------
library(dplyr, warn.conflicts = FALSE)

# cleaned dataset
nc_type_example_1_fixed <-
  nc_type_example_1 |>
  mutate(county = case_match(county, "PAMILCO" ~ "PAMLICO", .default = county))

add_geometry(nc_type_example_1_fixed, county, feature_type = "sf.nc")

## ----example-basic, fig.width=8, fig.height=2---------------------------------
library(ggplot2)

nc_type_example_1_fixed |>
  count(county, type) |>
  add_geometry(county, feature_type = "sf.nc") |>
  ggplot() +
  geom_sf(data = map_sf("sf.nc")) +
  geom_sf(aes(fill = n)) +
  facet_wrap(vars(type))

