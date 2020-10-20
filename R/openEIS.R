openDTA <- function(arch) {
  comienzo <- grep("^ZCURVE", readLines(arch))
  comienzo <- comienzo + 2
  tmp <- utils::read.delim2(arch, encoding = "UTF8", header = FALSE, skip = comienzo)
  tmp <- tmp[, c(3, 4, 5, 6)]
  tmp$file <- basename(arch)
  colnames(tmp) <- c("time", "freq", "real", "imag", "file")
  tmp$time <- as.numeric(tmp$time)
  tmp$freq <- as.numeric(tmp$freq)
  tmp$real <- as.numeric(tmp$real)
  tmp$imag <- as.numeric(tmp$imag)
  tmp$file <- as.factor(tmp$file)
  tmp
}

openZb <- function(arch) {
  comienzo <- grep("^\"Frequency\"", readLines(arch))
  comienzo <- comienzo + 3
  tmp <- utils::read.delim2(arch, encoding = "UTF8", header = FALSE, sep = ",", skip = comienzo, stringsAsFactors = FALSE)
  tmp <- tmp[, c(4, 1, 5, 6)]
  tmp$file <- basename(arch)
  colnames(tmp) <- c("time", "freq", "real", "imag", "file")
  tmp$time <- as.numeric(tmp$time)
  tmp$freq <- as.numeric(tmp$freq)
  tmp$real <- as.numeric(tmp$real)
  tmp$imag <- as.numeric(tmp$imag)
  tmp$file <- as.factor(tmp$file)
  tmp
}

openZ <- function(arch) {

  conn <- file(arch, open = "r")
  linn <- readLines(conn)
  close(conn)
  for (i in 1:length(linn)) {
    if (linn[i] == "End Comments")
      comienzo <- i
  }
  tmp <- utils::read.delim2(arch, encoding = "UTF8", header = FALSE, skip = comienzo, stringsAsFactors = FALSE)
  tmp <- tmp[, c(4, 1, 5, 6)]
  colnames(tmp) <- c("time", "freq", "real", "imag")
  tmp$time <- as.double(tmp$time)
  tmp$freq <- as.double(tmp$freq)
  tmp$real <- as.double(tmp$real)
  tmp$imag <- as.double(tmp$imag)
  tmp
}

openNOVA <- function(arch) {

  tmp <- utils::read.delim2(arch, encoding = "UTF8", header = FALSE, sep = ";", skip = 1)
  tmp <- tmp[, c(7, 2, 3, 4)]
  colnames(tmp) <- c("time", "freq", "real", "imag")
  tmp$imag <- tmp$imag * -1
  tmp
}


#'\code{openEIS()}
#'
#' Importa datos de impedancia de distintos softwares adquisidores
#'
#'
#' Esta función extrae la frecuencia , parte imaginaria y parte real de los archivos generados por:
#'
#'\itemize{
#'   \item *.DTA file,  Gamry Framework 7.06 version
#'   \item *.z file,  ZPlot software 2.6 and 2.6b version
#'   \item *.txt ascii AUTOLAB NOVA 2.1.3 version
#'}
#' @return dataframe con variables freq, real, imag
#' @export
#'
## @examples

openEIS <- function(arch) {
  ##arch <- path.expand(file.choose()) abre un dialogo.
  conn <- file(arch, open = "r")
  linn <- readLines(conn)
  for (i in 1:length(linn)) {
    # .DTA file, Gamry Framework 7.06 version
    if (linn[i] == "EXPLAIN") {
      close(conn)
      df <- openDTA(arch)
      break
    }
    # .z file, ZPlot software 2.6 version
    if (linn[i] == "ZPLOT2 ASCII") {
      close(conn)
      df <- openZ(arch)
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

