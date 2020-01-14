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
  x = format(x,
             digits = digits,
             trim = TRUE,
             drop0trailing = TRUE,
             scientific = FALSE,
             big.mark = " ")
  return(x)
}

