openCorrware <- function(arch) {

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
  tmp$time <- as.numeric(as.character(tmp$time))
  tmp
}

openGamry <- function(arch) {

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
# @examples

openCOR <- function(arch) {
  conn <- file(arch, open = "r")
  linn <- readLines(conn)
  for (i in 1:length(linn)) {
    # .DTA file, Gamry Framework 7.06 version
    if (linn[i] == "EXPLAIN") {
      close(conn)
      df <- openGamry(arch)
      break
    }
    # .cor file,  CorrWare for Windows: Version 2.6b
    if (linn[i] == "CORRW ASCII") {
      close(conn)
      df <- openCorrware(arch)
      break
    }
    # .z file, ZPlot software 2.6b version
    if (linn[i] == "\"ZPlotW Data File: Version 2.6b\"") {
      close(conn)
      df <- openZb(arch)
      break
    }
    # .txt ascii NOVA 2.1.3 version

    if (linn[i] == "Index;Frequency (Hz);Z' (Ω);-Z'' (Ω);Z (Ω);-Phase (°);Time (s)") {
      close(conn)
      df <- openNOVA(arch)
      break
    }

  }  #for
  df
}


