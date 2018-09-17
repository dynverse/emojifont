library(tidyverse)
library(jsonlite)

############# PROCESS emoji_data #############
url <- "https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json"
emoji_file <- tempfile(fileext = '.json')
download.file(url, destfile = emoji_file)

emoji_data <- jsonlite::fromJSON(readLines(emoji_file))


############# PROCESS fontawesome_data #############
release <- "fontawesome-free-5.3.1-web"

# download and unzip
url <- paste0("https://github.com/FortAwesome/Font-Awesome/releases/download/5.3.1/", release, ".zip")
zip_file <- tempfile(fileext = '.zip')
download.file(url, destfile = zip_file)

temp_dir <- tempfile()
dir.create(temp_dir)

unzip(zipfile = zip_file, exdir = temp_dir)

# copy ttfs
ttf_files <- list.files(temp_dir, pattern = "*.ttf", recursive = TRUE, full.names = TRUE)
file.copy(ttf_files, "inst/fonts/", overwrite = TRUE)

# read metadata
metadata <- jsonlite::read_json(paste0(temp_dir, "/", release, "/metadata/icons.json"))

# create df
fontawesome_data <- map_df(names(metadata), function(nm) {
  l <- metadata[[nm]]

  data_frame(
    fa = stringi::stri_unescape_unicode(paste0("\\u", l$unicode)),
    description = l$label,
    aliases = nm,
    tags = paste0(l$search$terms, collapse = ", "),
    html = paste0("&#x", l$unicode, ";"),
    styles = paste0(l$styles, collapse = ", ")
  )
}) %>%
  as.data.frame()

############# save sysdata #############
devtools::use_data(emoji_data, fontawesome_data, internal = TRUE, overwrite = TRUE)
