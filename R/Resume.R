#' Resume data
#'
#' @param data dataframe or vector
#' @param ... ...
#' @import dplyr tibble tidyr
#' @importFrom stats median sd quantile
#' @importFrom purrr map_chr
#' @importFrom rlang is_empty
#' @importFrom magrittr %>%
#'
#' @return tibble
#' @export
#'
#' @examples resume(iris)
resume <- function(data,
                   ...){

  if (nargs() > 1) data = select(data, ...)

  #definir la classe des variables
  type = map_chr(.x = data,
                 .f = class) %>%
    enframe

  type = suppressWarnings(type)


  if(is_empty(matches(vars = type$value,
                      match = "numeric|integer")) == FALSE){
    #NUMERIC
    df_ni = data %>%
      select_if(.predicate = function(col) is.numeric(col) |
                  is.integer(col)) %>%
      gather(variable,
             value) %>%
      group_by(variable) %>%
      summarise(n = length(value),
                n_missing = sum(is.na(value)),
                n_unique = length(unique(value)),
                mode = I(mode_stat(value,
                                   na.rm = TRUE)),
                pct_mode = I(length(value[value == mode])/length(value)*100,
                             digits = 2),
                min = I(min(value,
                            na.rm = TRUE)),
                max = I(max(value,
                            na.rm = TRUE)),
                mean = I(mean(value,
                              na.rm = TRUE),
                          digits = 2),
                sd = I(sd(value,
                          na.rm = TRUE),
                       digits = 2),
                quart25 = I(quantile(value,
                                     probs =  0.25,
                                     na.rm = TRUE),
                            digits = 2),
                median = I(quantile(value,
                                    probs = 0.5,
                                    na.rm = TRUE)),
                quart75 = I(quantile(value,
                                     probs =  0.75,
                                     na.rm = TRUE),
                            digits = 2),
                cent05 = I(quantile(value,
                                    probs = 0.05,
                                    na.rm = TRUE),
                           digits = 2),
                cent95 = I(quantile(value,
                                    probs = 0.95,
                                    na.rm = TRUE),
                           digits = 2),
                med_length = I(median(nchar(value),
                                      na.rm = TRUE)))
  }else{df_ni = NULL}


  df_ni = suppressWarnings(df_ni)

  if(is_empty(matches(vars = type$value,
                      match = "character|factor")) == FALSE){
    # CHARA
    df_cf = data %>%
      select_if(.predicate = function(col) is.character(col) |
                  is.factor(col)) %>%
      mutate_if(is.factor,
                as.character) %>%
      gather(variable,
             value) %>%
      group_by(variable) %>%
      summarise(n = length(value),
                n_missing = sum(is.na(value)),
                n_unique = length(unique(value)),
                mode = I(mode_stat(value,
                                   na.rm = TRUE)),
                pct_mode = I(length(value[value == mode])/length(value)*100,
                             digits = 2),
                med_length = I(median(nchar(value),
                                      na.rm = TRUE)))
  }else{df_cf = NULL}

  df_cf = suppressWarnings(df_cf)


  if(is.null(df_ni) == TRUE &
     is.null(df_cf) == TRUE){
    resume = stop("Erreur : l'objet ne possède pas de vecteur numerique, entier, caractere ou facteur. (Les vecteurs au format date ne sont pas pris en compte)")
  } else if(is.null(df_ni) == FALSE &
            is.null(df_cf) == TRUE){
    resume = df_ni %>%
      right_join(type,
                 by = c("variable" = "name")) %>%
      select(name = variable,
             type = value,
             everything())
  }else if(is.null(df_ni) == TRUE &
           is.null(df_cf) == FALSE){
    resume = df_cf %>%
      right_join(type,
                 by = c("variable" = "name")) %>%
      select(name = variable,
             type = value,
             everything())
  }else if(is.null(df_ni) == FALSE &
           is.null(df_cf) == FALSE){
    resume = df_ni %>%
      full_join(df_cf,
                by = names(df_cf)) %>%
      right_join(type,
                 by = c("variable" = "name")) %>%
      select(name = variable,
             type = value,
             everything())
  }else{}

  resume = suppressWarnings(resume)

  return(resume)

}
