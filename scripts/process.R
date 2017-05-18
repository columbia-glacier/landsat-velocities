library(magrittr)

# 3491: ETM+ Pan Mosaics (1999-2003)
# 3492: TM Mosaics (1984-1997)
# 2732: ETM+ Pan (1999-2003)
# 2731: ETM+ (1999-2003)
# 2733: TM (1984-1997)
# 2871: MSS 1-5 (1972-1987)
# 3211: Sys ETM+ L1G
# 

# Retrieve granules (LANDSAT image ids) from shapefiles
files <- "sources/tm" %>%
  list.files(pattern = "\\.dbf$", recursive = TRUE, full.names = TRUE)

granules <- lapply(files, function(file) {
  print(file)
  file %>%
    foreign::read.dbf(as.is = TRUE) %>%
    extract(1, c("img1", "img2")) %>%
    cbind(file)
}) %>%
  do.call("rbind", .)

granule_list <- unique(unlist(granules[c("img1", "img2")]))
parameters <- c("acquisition_date", "start_time", "stop_time")
url <- "https://earthexplorer.usgs.gov/form/metadatalookup/"

granule_dates <- lapply(granule_list, function(granule) {
  print(granule)
  query <- list(collection_id = 2731, entity_id = granule)
  response <- httr::GET(url, query = query)
  xml <- xml2::read_html(rawToChar(response$content))
  rows <- xml %>%
    xml2::xml_find_all("//table[@id = 'metadataTable']/tbody/tr")
  ind <- rows %>%
    xml2::xml_find_all("td[1]/a") %>%
    xml2::xml_attr("href") %>%
    gsub("^.*#([a-zA-Z0-9_]+).*$", "\\1", .) %>%
    match(parameters, .)
  values <- rows %>%
    extract(ind) %>%
    xml2::xml_find_all("td[2]") %>%
    xml2::xml_text()
  names(values) <- parameters
  as.data.frame(t(values))
}) %>%
  do.call("rbind", .)
  
# Write granules to file
# Retrieve image capture times from granules
# Rename rasters