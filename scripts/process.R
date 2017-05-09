library(magrittr)

# Retrieve granules (LANDSAT image ids) from shapefiles
files <- "sources/tm" %>%
  list.files(pattern = "\\.dbf$", recursive = TRUE, full.names = TRUE)
granules <- lapply(files, function(file) {
  print(file)
  file %>%
    foreign::read.dbf(as.is = TRUE) %>%
    extract(1, c("img1", "img2")) %>%
    cbind(file)
})

# Retrieve image capture times from granules
# Rename rasters