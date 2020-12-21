# ==============================================================================
# # input: all churches with respective date of opening and closure
# # output: unbalanced panel data with churches
# ==============================================================================
empresa_church <- fread(
    here("data/clean/empresa_religious.csv"),
    colClasses = "character"
)

# generate table with start and end
empresa_panel <- empresa_church %>%
    mutate(
        across(
            starts_with("date"),
            ~ str_extract(., "^\\d{4}") %>%
                as.integer
        )
    )

# generate two tables
# one with extinct churches, one with active ones
empresa_church_active <- empresa_panel %>% 
    filter(status_registration == "02")

empresa_church_extinct <- empresa_panel %>%
    filter(status_registration != "02")

panel_church_active <- empresa_church_active %>%
    select(
        cnpj, 
        date_start
    ) %>%
    pivot_longer(
        c(date_start),
        values_to = "year"
    ) %>% 
    group_by(cnpj) %>%
    complete(
        year = seq(min(year), 2020, by = 1)
    ) %>%
    ungroup() %>%
    select(-name)


panel_church_extinct <- empresa_church_extinct %>%
    select(
        cnpj,
        date_start,
        date_registration
    ) %>%
    rename(
        date_end = date_registration
    ) %>%
    pivot_longer(
        c(date_start, date_end),
        values_to = "year"
    ) %>% 
    group_by(cnpj) %>%
    complete(
        year = seq(min(year), max(year), by = 1)
    ) %>%
    ungroup() %>%
    select(-name)

panel_church <- panel_church_active %>%
    bind_rows(panel_church_extinct)
