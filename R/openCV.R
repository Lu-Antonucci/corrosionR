#' Open files of corrosion studies from different sources
#'
#' Open files of corrosion studies from different sources.
#' This version supports *.DAT* files of the Gamry Instruments software, for measuring
#' cyclic voltammetry.
#'
#' @param arch
#' *arch* = file text from measure
#' @return
#' Dataframe(time = Time, E = Potential, I = Current)
#' @export
#'
#' @examples

openCV <- function(arch) {
  
  conn <- file(arch, open = "r")
  linn <- readLines(conn)
  close(conn)
  for (i in 1:length(linn)) {
    if (linn[i] == "CURVE1\tTABLE")
      comienzo <- i + 2
  }
  
  tmp <- utils::read.delim2(arch, encoding = "UTF8", header = FALSE, skip = comienzo)
  tmp <- tmp[, c(3, 4, 5)]
  colnames(tmp) <- c("time", "E", "I") 
  tmp
}