library(DBI)
library(tidyverse)

con <- dbConnect(RSQLite::SQLite(), ":memory:")
copy_to(con, mtcars)

mtcars <- tbl(con, "mtcars") %>% head(n = 10)

summary <-
mtcars %>% 
  group_by(cyl) %>% 
  summarise(mpg = mean(mpg, na.rm = TRUE)) %>% 
  arrange(desc(mpg)) %>% 
  show_query()

summary %>% collect()