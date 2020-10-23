source("R/temas.R")

#' Genera gráfico de Nyquist o Cole-Cole
#'
#' @param df Dataframe con los datos de frecuencia, Real e Imag
#' @param color Color de los puntos
#' @param ... parametros usados en ggplot2
#'
#' @return Plot
#' @export
#'
# @examples

plotNyquist <- function(df, color = "red", ...){

    ggplot2::ggplot(df) +
    ggplot2::geom_point(ggplot2::aes(x=real, y=-imag, col=color, ...)) +
    ggplot2::xlab(expression(Z~Real~(Omega))) + ggplot2::ylab(expression(-Z~Imag~(Omega))) +
    theme_at()
}
