# create a table of unique cnpj raiz with religious denominations
# think about decision rule to define which denomination is
empresa_church <- fread(
    here("data/clean/empresa_religious.csv"),
    colClasses = "character"
)

church_denomination <- c(
    adventist = "adventista",
    afro_brazilian = "afro",
    apostologica = "igreja apostolica",
    anglican = "anglican",
    assembly_of_god = "ass[:print:]*deus",
    baptist = "batist[\\w]*",
    biblical_revival = "avivamento biblico",
    brazil_for_christ = "brasil p[a]*ra cristo",
    blessing_house = "casa da bencao",
    buddhism = c("budismo", "nitiren", "zen", "soka gakkai"),
    catholic = c(
        "dioces", "arquid", "filhas", "mitra", "catolica",
        "jesuitas", "salesiana", "carmelita", "paroquia",
        "prelazia", "missionarias", "catolico", "franciscana",
        "bispos", "(conselho indigenista missionario)", "(comissao pastoral)"
    ) %>%
        paste(collapse = "|"),
    candomble = "candomble",
    christian_community = "comunidade crista",
    congregational = c("congregacao crista", "congregacional") %>%
        paste(collapse = "|"),
    espirita = "espirita",
    evangelical_community = "comunidade evangelica",
    evangelho_quadrangular = "igreja do evangelho quadrangular",
    indigenous = c(
        "indigena", "(santo daime)", "vegetal", "barquinha", "neoxamanica"
    ) %>%
        paste(collapse = "|"),
    hinduism = "hindu",
    igreja_internacional = "igreja internacional",
    iurd = "igreja universal do reino de deus",
    lutheran = "luter[\\w]*",
    jehovah_witness = "testemunha[\\s]*[de\\s]*jeova",
    judaism = "sinagoga|judia",
    maranata = "maranata",
    methodist = "metodista",
    memnonite = "menonita[s]*",
    nazareth_church = "igreja do nazareno",
    new_life = "nova vida",
    orthodox = "ortodoxa",
    # pentecostal = c("pentecostal", "pent") %>%
    #     paste(collapse = "|"),
    prayer_chain = "cadeia da prece",
    presbiterian = "presbiterian[a|o]",
    religion_of_god = "religiao de deus",
    salvation_army = "exercito de salvacao",
    saints_of_last_days = "santo[s]* dos ultimos dias",
    shinto = "shinto",
    taoism = "\\btao\\b",
    umbanda = "umbanda"
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
  
# create denominations
empresa_church_raiz <- empresa_church_raiz %>%
    mutate(
        denomination = map_chr(
            company_name,
            ~ create_denomination(., church_denomination)
        )
    ) %>%
    separate(
        denomination,
        c("denomination_primary", "denomination_secondary"),
        sep = ",",
        remove = TRUE,
        extra = "merge",
        fill = "right"
    ) %>%
    filter(
        !is.na(denomination_secondary)
    )

empresa_church_raiz %>%
    fwrite(
        here("data/clean/empresa_church_raiz_denomination.csv")
    )