# run modules to extract, clean and compile new analysis

library(RSQLite)
library(tidyverse)
library(here)
library(data.table)

source("source/utils.R")

modules <- c(
    "extract_religious_org.R",
    "hello"
) %>%
    map_chr(here)

walk(
    modules,
    source
)