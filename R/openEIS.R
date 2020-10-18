#' Open files of corrosion studies from different sources
#'
#' Open files of corrosion studies from different sources.
#' This version supports *.DAT* files of the Gamry Instruments software, for measuring
#' electrochemical impedance.
#'
#' @param arch
#' *arch* = file text from measure
#' @return
#' Dataframe(freq = Frequency, real = Zreal, imag = Zimag)
#' @export
#'
#' @examples

openDTA <- function(arch) {
  
  conn <- file(arch, open = "r")
  linn <- readLines(conn)
  close(conn)
  for (i in 1:length(linn)) {
    if (linn[i] == "ZCURVE\tTABLE")
      comienzo <- i + 2
  }
  
  tmp <- utils::read.delim2(arch, encoding = "UTF8", header = FALSE, skip = comienzo)
  tmp <- tmp[, c(4, 5, 6)]
  colnames(tmp) <- c("freq", "real", "imag") 
  tmp
}