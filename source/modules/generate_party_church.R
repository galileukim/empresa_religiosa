# read in data
election <- read_csv(
    here("data/raw/election_local.csv.gz")
) %>%
    filter(
        election_year %in% c(2012, 2016)
    )

church_panel <- read_csv(
    here("data/clean/empresa_church_panel.csv")
) %>%
    filter(
        year %in% c(2011, 2015, 2019)
    )

church_denomination <- read_csv(
    here("data/clean/empresa_church_raiz_denomination.csv")
) %>% 
    filter(
        denomination_primary %in% c("iurd", "assembly_of_god")
    ) %>%
    distinct(
        cnpj, denomination_primary
    ) %>% 
    rename(
        denomination = denomination_primary
    ) %>%
    mutate(
        denomination = if_else(denomination != "iurd", "ad", denomination)
    )

church_mun <- read_csv(
    here("data/clean/empresa_religious.csv")
) %>%
    select(
        cnpj,
        cod_ibge_6
    )

# generate panel data for election with nr. vereadores and dummy for mayor
election_panel <- election %>% 
    filter(round == 1) %>%
    group_by(cod_ibge_6, election_year) %>%
    summarise(
        total_vereadores_prb = sum(position == "vereador" & party == "prb"),
        total_vereadores_psc = sum(position == "vereador" & party == "psc"),
        is_running_mayor_prb = any(position == "prefeito" & party == "prb"),
        is_running_mayor_psc = any(position == "prefeito" & party == "psc")
    ) %>%
    pivot_wider(
        names_from = election_year,
        values_from = c(starts_with("total"), starts_with("is_running"))
    )

# generate number of churches by denomination, by year
church_panel_total <- church_panel %>%
    inner_join(church_denomination, by = "cnpj") %>%
    inner_join(church_mun, by = "cnpj") %>%
    group_by(cod_ibge_6, denomination, year) %>%
    summarise(total_churches = n()) %>%
    pivot_wider(
        names_from = c(denomination, year),
        names_prefix = "total_churches_",
        values_from = total_churches
    )

panel_church_party <- election_panel %>% 
    inner_join(
        church_panel_total,
        by = c("cod_ibge_6")
    )

panel_church_party %>% 
    write_csv(
        here("data/clean/party_church_panel.csv")
    )
