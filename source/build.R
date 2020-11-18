# run modules to extract, clean and compile new analysis
source(
    here::here("source/requirements.R")
)

modules <- c(
    "extract_religious_org",
    "classify_church_denominations"
) %>%
    paste(".R") %>%
    map_chr(here)

walk(
    modules,
    source
)