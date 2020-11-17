cnpj_db <- dbConnect(
    dbDriver("SQLite"),
    here("data/raw/database_cnpj.db")
)

empresa <- tbl(cnpj_db, "cnpj_dados_cadastrais_pj")

empresa_religious <- empresa %>%
    filter(cnae_fiscal == "9491000") %>%
    collect()

empresa_religious %>%
    fwrite("data/clean/empresa_religious.csv")