#' DigitLayout
#'
#' @param x un vecteur numérique
#' @param digits nombre après la virgule
#' @param ... ,,,
#'
#' @return un vecteur numérique mis en forme selon les normes française
#' @export
#'
#' @examples
#' test = c(112582,4,524.218,67,.1,.14444,0)
#' I(test,digits = 2)

I <- function(x,
              digits = NULL,
              ...){

  if(is.null(digits) == TRUE){
    x = x
  } else if (is.numeric(digits) == TRUE |
             is.integer(digits) == TRUE){
    x = round(x,
              digits = digits)
  } else{
    stop("digits doit etre un chiffre")
  }

  x = format(x,
             # digits = 2,
             trim = TRUE,
             drop0trailing = TRUE,
             scientific = FALSE,
             big.mark = " ")
  return(x)
}

