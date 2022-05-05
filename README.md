
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
-   Use DURIAN on Seurat objects directly, and perform cell signaling
    analysis in CellChat in `vignette("signaling")`.

## Installation

#### Dependencies

``` julia
ENV["R_HOME"]="/usr/local/lib/R"
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

Sys.setenv(JULIA_HOME="/usr/local/julia-1.7.2/bin")
install.packages("JuliaCall")
library(JuliaCall)
julia_setup(JULIA_HOME = Sys.getenv("JULIA_HOME"),verbose=TRUE,rebuild = TRUE,install=FALSE)
```

#### Package

``` r
install_github("mkarikom/DURIAN")
```

#### Module Selection

<div>

DURIAN supports the integration of custom deconvolution modules, even
modules written in other languages, such as Julia. Module selection is
made using the `deconv_method` argument to `DURIAN::run_durian` and the
default is `deconv_method = "MuSiC"`.

Current deconvolution alternatives include:

-   fast, NNLS regression using [MuSiC
    (R)](https://github.com/xuranw/MuSiC)
-   distributed Monte Carlo inference using [dsLDA
    (Julia)](https://github.com/mkarikom/DistributedStwdLDA.jl)

</div>
