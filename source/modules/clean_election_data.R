identifiers <- fread(
    here("data/raw/data_rosettastone.csv")
) %>%
    transmute(
        cod_tse = codetse,
        cod_ibge_6 = codeipea
    )

election <- read_csv(
    here("data/raw/election_local.csv.gz")
) %>%
    filter(
        election_year %in% c(2012, 2016)
    ) 
    
election <- election %>%
    distinct(
        cod_ibge_6,
        position,
        candidate_num,
        election_year,
        .keep_all = TRUE
    ) %>%
    select(
        cod_ibge_6,
        party,
        position,
        election_year
    )

election_2020 <- read_csv2(
    here("data/raw/candidate_local_2020.csv")
) %>%
    transmute(
        cod_tse = SG_UE,
        party = SG_PARTIDO,
        position = DS_CARGO,
        candidate_num = NR_CANDIDATO,
        election_year = 2020
    ) %>%
    mutate(
        across(where(is.character), str_to_lower),
        cod_tse = as.integer(cod_tse)
    ) %>%
    filter(position %in% c("prefeito", "vereador")) 
    
election_2020 <- election_2020 %>%
    distinct(
        cod_tse,
        candidate_num,
        position,
        election_year,
        .keep_all = TRUE
    ) %>%
    left_join(
        identifiers, by = "cod_tse"
    ) %>%
    select(
        cod_ibge_6,
        party,
        position,
        election_year
    )

election_complete <- election %>%
    bind_rows(election_2020)

election_complete %>% 
    write_csv(
        here("data/clean/election_local.csv.gz")
    )
