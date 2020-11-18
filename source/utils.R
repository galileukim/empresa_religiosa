standardize_chars <- function(data) {
  data <- data %>%
    mutate_if(
      is.character,
      ~ stringi::stri_trans_general(., "latin-ascii") %>%
        str_to_lower()
    )

  return(data)
}

rename_with_dictionary <- function(data, dictionary) {
  vars_to_rename <- intersect(
    names(data),
    dictionary[["original_name"]]
  )

  temp_dictionary <- dictionary %>%
    filter(original %in% vars_to_rename) %>%
    deframe()

  data_renamed <- data %>%
    rename(!!temp_dictionary)

  return(data_renamed)
}

create_dictionary <- function(named_list_of_vars) {
  dictionary <- enframe(
    named_list_of_vars,
    "original_name",
    "new_name"
  )

  dictionary <- dictionary %>%
    unnest(c(new_name))

  return(dictionary)
}