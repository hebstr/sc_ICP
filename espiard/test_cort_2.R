library(tidyverse)
library(lubridate)

load()
setwd("~")
source("JULIEN/fonctions/_fonctions.R")

data <-
data |> 
  mutate(code = as_factor(code),
         nombre = as.numeric(str_replace(nombre, ",", ".")),
         date_data = dmy(date_data)) |> 
  pivot_wider(names_from = code, values_from = nombre)
