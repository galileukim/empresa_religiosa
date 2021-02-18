church_raiz <- read_csv(
    here("data/clean/empresa_church_raiz_denomination.csv")
)

church_panel <- read_csv(
    here("data/clean/empresa_church_panel.csv")
)

church_denomination <- church_raiz %>%
    select(
        cnpj,
        company_name,
        cnpj_raiz,
        denomination = denomination_primary
    )

church_denomination_panel <- church_denomination %>%
    inner_join(
        church_panel,
        by = "cnpj"
    ) %>%
    filter(
        !is.na(denomination)
    )

denomination_herfindahl_2010 <- church_denomination_panel %>%
    filter(year == 2010) %>%
    count(denomination, cnpj_raiz) %>%
    group_by(denomination) %>%
    summarise(
        herfindahl_2010 = sum(
            (n/sum(n))^2
        ),
        total_churches_2015 = sum(n),
        .groups = "drop"
    )

denomination_herfindahl_2015 <- church_denomination_panel %>%
    filter(year == 2015) %>%
    count(denomination, cnpj_raiz) %>%
    group_by(denomination) %>%
    summarise(
        herfindahl_2015 = sum(
            (n/sum(n))^2
        ),
        total_churches_2015 = sum(n),
        .groups = "drop"
    )

denomination_herfindahl <- denomination_herfindahl_2010 %>%
    left_join(
        denomination_herfindahl_2015,
        by = "denomination"
    )

write_csv(
    denomination_herfindahl,
    here("data/clean/empresa_church_herfindahl.csv")
)
