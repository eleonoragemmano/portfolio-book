library(tidyverse)
library(pins)

# Initialize a versioned board inside 'portfolio-book/pins/'
bd <- pins::board_folder(path = "portfolio-book/data/pins/", versioned = TRUE)

# Set source URL and temporary file
source_url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/hepatitis/hepatitis.data"
temp_file <- tempfile(fileext = ".data")

# Download raw data temporarily
download.file(url = source_url, destfile = temp_file, mode = "wb", quiet = TRUE)

# Define column names
col_names <- c(
  "class", "age", "sex", "steroid", "antivirals", "fatigue", 
  "malaise", "anorexia", "liver_big", "liver_firm", "spleen_palpable", 
  "spiders", "ascites", "varices", "bilirubin", "alk_phosphate", 
  "sgot", "albumin", "protime", "histology"
)

# Read temporary CSV
hepatitis_raw <- readr::read_csv(
  file = temp_file,
  col_names = col_names,
  na = "?",
  show_col_types = FALSE
)

# Remove temporary file
unlink(temp_file)

# Create versioned snapshot in portfolio-book/pins/
pins::pin_write(
  board = bd, 
  x = hepatitis_raw, 
  name = "hepatitis",
  type = "rds",
  description = "UCI Hepatitis dataset versioned snapshot"
)

message("Data pinned successfully in data/pins/")
