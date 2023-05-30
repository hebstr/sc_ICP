library(tidyverse)
library(lubridate)

source("database_connection/connectDatabase.R")
source("fonctions/_fonctions.R")

edbm <- 
map(c(pat = "edbm_zpat.ehop_patient_mapping",
      sej = "edbm_zpat.ehop_sejour_mapping",
      texte = "edbm_eds.ehop_texte"),
    ~ to_tbl(., head = 1000))

data <-
to_tbl("espiard/data.csv", db = FALSE) |> 
  left_join(edbm$pat) |> left_join(edbm$sej) |> left_join(edbm$texte) |> 
  relocate(ipp, id_pat, retrait, iep, id_sej, sexe, datenaissance) |> 
  relocate(diagnostic, .after = last_col()) |> 
  mutate(across(starts_with("cort"), ~ na_if(., str_match(., "[:alpha:].+"))),
         across(starts_with("date"), as_date),
         across(c("sexe", "diagnostic"), ~ factor(.))) |>
  select(-c(txtid, id_entrepot, contexte, certitude, rang_contexte), -contains("acth"))

