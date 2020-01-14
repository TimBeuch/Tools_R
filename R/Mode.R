#' Mode unique
#'
#' @param x vecteur
#' @param na.rm logical, indique si les NA doivent etre pris en compte (FALSE par defaut)
#'
#' @return un character (si le mode correspond à plusieurs éléments, indique le premier)
#' @export
#'
#' @examples
#' test = c(1,1,1,1,2,2,2,2,3,4,4,4,4)
#' mode_stat (test)
mode_stat <- function(x,
                      na.rm = FALSE) {

  if(na.rm == "TRUE"){
    x = x[!is.na(x)]
  }else{}

  ux <- unique(x)
  mode = ux[which.max(tabulate(match(x, ux)))]

  return(mode)
}

#' Modes liste
#'
#' @param x vecteur
#' @param na.rm logical, indique si les NA doivent etre pris en compte (FALSE par defaut)
#'
#' @return chaine de character (si le mode correspond à plusieurs éléments, les indique tous)
#' @export
#'
#' @examples
#' test = c(1,1,1,1,2,2,2,2,3,4,4,4,4)
#' modes_stat(test)
modes_stat <- function(x,
                       na.rm = FALSE) {

  if(na.rm == "TRUE"){
    x = x[!is.na(x)]
  }else{}

  ux <- unique(x)
  tab <- tabulate(match(x, ux))
  modes = ux[tab == max(tab)]

  return(modes)
}
