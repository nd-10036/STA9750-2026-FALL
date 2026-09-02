if (!require("leaflet")) install.packages("leaflet")
if (!require("tidyverse")) {
  install.packages("tidyverse")
}
library(tidyverse)
library(rvest)
library(leaflet)

pAGE <- read_html("https://en.wikipedia.org/wiki/Baruch_College")
pAGE |>
  html_element(".latitude") |>
  html_text2() -> BaruchLatitude
baruch_longitude <- pAGE |>
  html_element(".longitude") |>
  html_text2()

BaruchLatitude <- sum(as.numeric(strsplit(
  BaruchLatitude,
  "[^0123456789]"
)[[1]]) * (1 / 60)^(0:2), na.rm = TRUE)
baruch_longitude <- sum(as.numeric(strsplit(baruch_longitude, "[^0123456789]")[[1]]) *
  (1 / 60)^(0:2), na.rm = TRUE)

leaflet() |>
  addTiles() |>
  setView(-baruch_longitude, BaruchLatitude,
    zoom = 17
  ) |>
  addPopups(
    -baruch_longitude,
    BaruchLatitude, "Look! It's <b>Baruch College</b>!"
  ) |>
  print()
