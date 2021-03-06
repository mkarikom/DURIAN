
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DURIAN <img src="man/figures/logo.svg" align="right" alt="" width="120" />

DURIAN (Deconvolution and mUltitask-Regression-based ImputAtioN) is a
hybrid, iterative method for imputation of drop-out in single-cell
expression data. Automatic recovery of missing single-cell reads is
supervised by deconvoluted bulk expression data.

For examples of pipelines involving DURIAN, users should consult [the
scripts](https://github.com/mkarikom/DURIAN_paper) used to generate the
benchmarking and figures for our paper.

## Get Started

-   Installation: see below
-   Basic usage of DURIAN running and visualizing imputation of Human
    single-cell data in `vignette("basic_usage")`.
-   Selection of the DURIAN deconvolution module, including R/C++ and
    Julia-based modules `vignette("module_selection")`.
-   Use DURIAN on Seurat objects directly, and perform cell signaling
    analysis in CellChat in `vignette("signaling")`.

## Installation

#### Dependencies

``` julia
ENV["JULIA_PROJECT"]=pwd()
ENV["R_HOME"]="/usr/local/lib/R"
using Pkg
Pkg.add("Distributed")
Pkg.add("RCall")
Pkg.build("RCall")
using RCall

Pkg.add(url="https://github.com/mkarikom/DistributedStwdLDA.jl.git")
```

``` r
# Install the latest version and dependencies from github
library(devtools)
devtools::install_github("mkarikom/MuSiC@biobaseImport")
devtools::install_github("mkarikom/mtSCRABBLE")
install.packages("foreach")

Sys.setenv(JULIA_HOME="/usr/local/julia-1.6.6/bin")

install.packages("JuliaCall")
library(JuliaCall)
julia_setup(JULIA_HOME = Sys.getenv("JULIA_HOME"),verbose=TRUE,rebuild = TRUE,install=FALSE)
```

#### Package

``` r
install_github("mkarikom/DURIAN")
```
