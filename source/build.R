# run modules to extract, clean and compile new analysis

library(RSQLite)
library(tidyverse)
library(here)

modules <- c(
    "extract_religious_org.R",
    "hello"
) %>%
    map_chr(here)

walk(
    modules,
    source
)