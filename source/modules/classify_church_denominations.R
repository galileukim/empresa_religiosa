# create a table of unique cnpj raiz with religious denominations
# think about decision rule to define which denomination is

religious_org <- fread(
    here("data/clean/empresa_religious.csv")
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
    ),
    assembly_of_god = "ass[:print:]*deus",
    baptist = "batist[\\w]*",
    salvation_army = "exercito de salvacao",
    luteran = "luter[\\w]*",
    espirita = c("espirita", "umbadista", "cultos afros"),
    ieq = "igreja do evangelho quadrangular",
    iurd = "igreja universal do reino de deus",
    sara_nossa_terra = "sara nossa terra",
    
)

religious_org %>%
    filter(str_detect(company_name, "universal")) %>%
    count(company_name, sort = T) %>%
    head(20)