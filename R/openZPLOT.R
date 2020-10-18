#' Open files of corrosion studies from different sources
#'
#' Open files of corrosion studies from different sources.
#' This version supports *.Z* files of the ZPlot TM software, for measuring
#' electrochemical impedance.
#'
#' @param arch
#' *arch* = file text from measure
#' @return
#' Dataframe(freq = Frequency, real = Zreal, imag = Zimag)
#' @export
#'
#' @examples

openZPLOT <- function(arch) {
  
  conn <- file(arch, open = "r")
  linn <- readLines(conn)
  close(conn)
  for (i in 1:length(linn)) {
    if (linn[i] == "\"Frequency\"")
      comienzo <- i + 3
  }
  
  tmp <- utils::read.delim2(arch, encoding = "UTF8", header = FALSE, sep = ",", skip = comienzo, stringsAsFactors = FALSE)
  tmp <- tmp[, c(1, 5, 6)]
  colnames(tmp) <- c("freq", "real", "imag")
  tmp$freq <- as.double(tmp$freq)
  tmp$real <- as.double(tmp$real)
  tmp$imag <- as.double(tmp$imag)
  tmp
}
