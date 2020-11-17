standardize_chars <- function(data){
  data <- data %>% 
    mutate_if(
    is.character,
    ~stringi::stri_trans_general(., "latin-ascii") %>% 
      str_to_lower
  )
  
  return(data)
}