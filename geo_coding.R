# This R code is used to Geo-Code the physical address locations using Google API Key in R


library(tidyverse)
library(ggmap)
library(ggplot2)
library(dplyr)
library(sf)
library(leaflet)
Rx_Drop_Off_Locations <- readr::read_csv("Rx_Drop_Off_Locations.csv")

Rx_Drop_Off_Locations <- Rx_Drop_Off_Locations %>% mutate(
  search_address = paste(address, city, state, zip, sep = ", ")
)

register_google(key = "YOUR GOOGLE API KEY", write = TRUE)

Rx_Drop_Off_Locations <- Rx_Drop_Off_Locations %>%
  filter(!is.na(search_address)) %>%
  mutate_geocode(search_address)  #One NA value due to Address
# don't include the variable for the ID
#mat_locations <- mat_locations %>%
#select(-X1)

usethis::use_data(Rx_Drop_Off_Locations, overwrite = TRUE)

