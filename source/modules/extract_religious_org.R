message("connect to database")
cnpj_db <- dbConnect(
    dbDriver("SQLite"),
    here("data/raw/database_cnpj.db")
)

empresa <- tbl(cnpj_db, "cnpj_dados_cadastrais_pj")

message("extract religious orgs")
empresa_religious <- empresa %>%
    filter(cnae_fiscal == "9491000") %>%
    collect()

# ---------------------------------------------------------------------------- #
message("clean up data")
# load up identifiers from DATASUS to convert municipal codes
municipal_identifiers <- fread(
  here("data/raw/cadmun_sus.csv"),
  colClasses = "character"
)

municipal_identifiers <- municipal_identifiers %>% 
  standardize_chars() %>% 
  select(
    cod_ibge_6 = MUNCOD,
    status = SITUACAO,
    cod_siafi = MUNSIAFI,
    name_mun_sus = MUNNOMEX
  )

empresa_religious_clean <- empresa_religious %>%
    filter(cod_pais == "") %>% # only churches with brazilian origin
    transmute(
        cnpj,
        state = uf,
        cod_siafi = str_pad(codigo_municipio, 4, "left", 0),
        name_mun_siafi = municipio,
        capital_social = capital_social_empresa,
        size = porte_empresa,
        id_branch = identificador_matriz_filial,
        company_name = razao_social,
        company_codename = nome_fantasia,
        status_registration = situacao_cadastral,
        date_registration = data_situacao_cadastral,
        type_organization = codigo_natureza_juridica,
        date_start = data_inicio_atividade,
        cnae = cnae_fiscal
    ) %>%
    standardize_chars()

empresa_religious_clean <- empresa_religious_clean %>%
    left_join(
        municipal_identifiers,
        by = "cod_siafi"
    )

empresa_religious_clean <- empresa_religious_clean %>%
    select(
        state,
        cod_ibge_6,
        cod_siafi,
        cnae,
        cnpj,
        company_name,
        company_subname,
        name_mun = name_mun_siafi,
        capital_social,
        size,
        id_branch,
        status_registration,
        cod_legal_status,
        date_registration,
        date_start
    )

empresa_religious_clean %>%
    fwrite("data/clean/empresa_religious.csv")