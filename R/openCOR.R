openCorrware <- function(arch) {
  comienzo <- grep("^End Comments", readLines(arch))
  tmp <- utils::read.delim2(arch, encoding = "UTF8", header = FALSE, skip = comienzo)
  tmp <- tmp[, c(3, 1, 2)]
  tmp$file <- basename(arch)
  colnames(tmp) <- c("time", "E", "I", "file")
  tmp$E <- as.numeric(as.character(tmp$E))
  tmp$I <- as.numeric(as.character(tmp$I))
  tmp$time <- as.numeric(as.character(tmp$time))
  tmp$file <- as.factor(tmp$file)
  tmp
}

openGamry <- function(arch) {
  comienzo <- grep("^CURVE", readLines(arch))
  comienzo <- comienzo + 2
  tmp <- utils::read.delim2(arch, encoding = "UTF8", header = FALSE, skip = comienzo)
  tmp <- tmp[, c(3, 4, 5)]
  tmp$file <- basename(arch)
  colnames(tmp) <- c("time", "E", "I", "file")
  tmp$E <- as.numeric(as.character(tmp$E))
  tmp$I <- as.numeric(as.character(tmp$I))
  tmp$time <- as.numeric(as.character(tmp$time))
  tmp$file <- as.factor(tmp$file)
  tmp
}
#'\code{openCOR()}
#'
#' Open files of corrosion studies from different sources.
#' For measuring cyclic voltammetry, open circuit potential, and potentiodinamycs.
#'
#' @param arch
#'  \itemize{
#'   \item *.DTA file,  Gamry Framework 7.06 version
#'   \item *.cor file,  CorrWare TM software 2.6 and 2.6b version
#'#'}
#'
#' @return Dataframe con las siguentes columnas:
#'\itemize{
#'   \item time: Tiempo transacurrido desde el comienzo de la
#'   medida, (*s*)
#'   \item E: Potencial, (*volts*).
#'   \item I: Corriente, (*Amperes*).
#'   \item file: Nombre del archivo.
#'}
#' @export
#'
#' @examples
#' # Abre medida Voltametŕía Cíclica del software Framework
#' v. 7.06 de Gammry
#'
#' file <- "/corrosionR/extdata/CV_Framework_version7_06.DTA"
#' medida <- openCOR(paste(.libPaths()[1], file, sep=""))

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

  }  #for
  df
}


