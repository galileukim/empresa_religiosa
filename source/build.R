# run modules to extract, clean and compile new analysis
source(
    here::here("source/requirements.R")
)

modules <- c(
    "extract_religious_org",
    "generate_panel_religious_org",
    "classify_church_denominations",
    "generate_herfindahl_index",
    "clean_election_data",
    "generate_party_church"
) %>%
    paste(".R") %>%
    map_chr(here)

walk(
    modules,
    source
)