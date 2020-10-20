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

nyquist <- function(df, color ="red", ...){

  ggplot2::ggplot(df) +
    ggplot2::geom_point( ggplot2::aes(real, -imag), col = color, ...) +
    ggplot2::xlab(expression(Z~Real~(Omega))) + ggplot2::ylab(expression(-Z~Imag~(Omega))) +
    ggplot2::theme_bw()+
    ggplot2::theme(plot.title = ggplot2::element_text(size=14, face="bold.italic"),
                   axis.title.x = ggplot2::element_text(size=14, face="bold"),
                   axis.title.y = ggplot2::element_text(size=14, face="bold"))

}
