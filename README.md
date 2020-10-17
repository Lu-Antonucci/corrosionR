
# corrosionR

<!-- badges: start -->
<!-- badges: end -->

The *Electrochemical Data Analysis for Reproducible Research package* 
provides a working environment for the analysis of data from corrosion 
measurements of equipment that provides its own proprietary software, but 
does not offer the flexibility a researcher would want, nor does it 
accommodate a reproducible workflow.

## Installation

You can install the released version of corrosionR from [GITHUB](https://github.com/mendivilg/corrosionR) with:

``` r
install.packages("devtools")
library(devtools)
install_github("mendivilg/corrosionR")

```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(corrosionR)
## basic example code
openCOR("path/file.cor")
```

## How to cite

``` r
citation("corrosionR")
```

