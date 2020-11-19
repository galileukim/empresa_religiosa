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
    evangelical = "igreja evang[\\w]+"
)

# note that every cnpj_raiz has the same name
# so we can simply create a table of cnpj_raiz
# with each unique company_name
empresa_church_raiz <- religious_org %>%
    mutate(
        cnpj_raiz = str_sub(cnpj, 1, 8)
    ) %>%
    distinct(
        cnpj_raiz,
        company_name
    )

sample_church <- empresa_church_raiz %>%
    sample_n(50)
    
sample_church %>%
    mutate(
        denomination = map_chr(
            company_name,
            ~ create_denomination(., church_denomination)
        )
    ) %>%
    write_csv(
        here("data/sample/church_denomination_sample.csv")
    )