library(RSQLite)
library(tidyverse)
library(here)

cnpj_db <- dbConnect(
    dbDriver("SQLite"),
    here("data/raw/bd_dados_qsa_cnpj.db")
)

empresa <- tbl(cnpj_db, "cnpj_dados_cadastrais_pj")

empresa_religious <- empresa %>%
    filter(cnae_fiscal == "9491000") %>%
    head(100) %>%
    collect()

empresa_religious %>%
    writexl::write_xlsx("data/clean/empresa_religious_sample.xlsx")