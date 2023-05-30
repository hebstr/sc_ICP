library(tidyverse)
library(lubridate)

source("database_connection/connectDatabase.R")
source("fonctions/_fonctions.R")

cort <-
to_tbl("edbm_eds.ehop_entrepot_structure
       where code in ('CORTT08H', 'CORTT16H', 'CORTT24H')") |> 
  select("id_pat", "id_sej", "code", "nombre", "date_data", "texte") |> 
  mutate(code = as_factor(code),
         nombre = as.numeric(str_replace(nombre, ",", ".")),
         date_data = dmy(date_data))


#  pivot_wider(names_from = code, values_from = nombre)




count(cort, texte) |> arrange(desc(n))

