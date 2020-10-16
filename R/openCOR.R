#' Open files of corrosion studies from different sources
#'
#' Open files of corrosion studies from different sources.
#' This version supports *.cor* files of the CorrWare TM software, for measuring
#' cyclic voltammetry, open circuit potential, and potentiodinamycs.
#'
#' @param arch
#' *arch* = file text from measure
#' @return
#' Dataframe(E = Potential, I = Current, time = Time)
#' @export
#'
#' @examples

openCOR <- function(arch) {

  conn <- file(arch, open = "r")
  linn <- readLines(conn)
  close(conn)
  for (i in 1:length(linn)) {
    if (linn[i] == "End Comments")
      comienzo <- i
  }

  tmp <- utils::read.delim2(arch, encoding = "UTF8", header = FALSE, skip = comienzo)
  tmp <- tmp[, c(1, 2, 3)]
  colnames(tmp) <- c("E", "I", "time")
  tmp$E <- as.numeric(as.character(tmp$E))
  tmp$I <- as.numeric(as.character(tmp$I))
  tmp$tiempo <- as.numeric(as.character(tmp$tiempo))
  tmp
}
