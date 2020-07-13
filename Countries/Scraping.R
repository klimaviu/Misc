
library(XML)
library(httr)
library(janitor)
library(tidyverse)

theurl <- "http://statisticstimes.com/geography/countries-by-continents.php"
doc <- htmlParse(GET(theurl, user_agent("Mozilla")))
results <- xpathSApply(doc, "//*/table[@id='table_id']")
results <- readHTMLTable(results[[1]])
rm(doc)

results <- results %>% 
  clean_names()%>% 
  select(country_or_area, region_1, continent) %>% 
  rename(region = region_1)

write.csv(results, "Countries/countries_and_continents.csv")
