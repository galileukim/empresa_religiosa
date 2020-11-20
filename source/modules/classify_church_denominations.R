# create a table of unique cnpj raiz with religious denominations
# think about decision rule to define which denomination is
empresa_church <- fread(
    here("data/clean/empresa_religious.csv"),
    colClasses = "character"
)

church_denomination <- c(
    presbiterian = "presbiterian[a|o]",
    methodist = "metodista",
    adventist = "adventista",
    catholic = c(
        "dioces", "arquid", "filhas", "mitra", "catolica",
        "jesuitas", "salesiana", "carmelita", "paroquia",
        "prelazia", "missionarias", "catolico", "franciscana",
        "bispos", "conselho indigenista missionario", "comissao pastoral"
    ) %>%
        paste(collapse = "|"),
    assembly_of_god = "ass[:print:]*deus",
    congregacao_crista = "congregacao crista",
    baptist = "batist[\\w]*",
    salvation_army = "exercito de salvacao",
    luteran = "luter[\\w]*",
    espirita = c("espirit", "umbadista", "cultos afros") %>%
        paste(collapse = "|"),
    ieq = "igreja do evangelho quadrangular",
    iurd = "igreja universal do reino de deus",
    pentecostal = c("pentecostal", "igreja[:print:]*pent") %>%
        paste(collapse = "|"),
    candomble = "umbanda",
    evangelical = "igreja evang[\\w]+",
    muslim = "islam",
    igreja_international = "igreja internacional",
    apostologica = "igreja apostolica",
    saints_of_last_days = "santos dos ultimos dias"
)

# note that every cnpj_raiz has the same name
# so we can simply create a table of cnpj_raiz
# with each unique company_name
empresa_church_raiz <- empresa_church %>%
    mutate(
        cnpj_raiz = str_sub(cnpj, 1, 8)
    ) %>%
    distinct(
        cnpj_raiz,
        company_name
    )
    
# empresa_church_raiz <- 

sample_church %>%
    mutate(
        denomination = map_chr(
            company_name,
            ~ create_denomination(., church_denomination)
        )
    ) %>%
    separate(
        denomination,
        c("denomination_main", "denomination_secondary"),
        sep = ",",
        remove = TRUE,
        extra = "merge",
        fill = "right"
    )

# join with original dataset and attribute denomination according to
# cnpj raiz
empresa_church <- empresa_church %>% 
    mutate(
        cnpj_raiz = str_sub(cnpj, 1, 8)
    ) %>%
    left_join(
        empresa_church_raiz,
        by = "cnpj_raiz"
    )

empresa_church %>%
    fwrite(
        here("data/clean/empresa_church_with_denomination.csv.gz"),
        compress = "gzip"
    )