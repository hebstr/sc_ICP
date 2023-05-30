rm(list = ls())
source("database_connection/connectDatabase.R")
source("fonctions/_fonctions.R")

admin_med <-
db_extract(db = "DATA_EDS.ADMIN_MEDICAMENTS",
           sample = 0.005) |>
  drop_na(nom_commercial)

