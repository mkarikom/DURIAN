
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DURIAN <img src="man/figures/logo.svg" align="right" alt="" width="120" />

DURIAN (Deconvolution and mUltitask-Regression-based ImputAtioN) is a
hybrid, iterative method for imputation of drop-out in single-cell
expression data. Automatic recovery of missing single-cell reads is
supervised by deconvoluted bulk expression data.

For examples of pipelines involving DURIAN, users should consult [the
scripts](https://github.com/mkarikom/DURIAN_paper) used to generate the
benchmarking and figures for our paper.

## Installation

### Dependencies

``` julia
ENV["R_HOME"]="/usr/local/lib/R"
#> "/usr/local/lib/R"
Pkg.add("RCall")
Pkg.build("RCall")
using RCall

Pkg.add(url="https://github.com/mkarikom/DistributedStwdLDA.jl.git")
```

``` r
# Install the latest version and dependencies from github
library(devtools)
#> Loading required package: usethis
devtools::install_github("mkarikom/MuSiC@biobaseImport")
#> Skipping install of 'MuSiC' from a github remote, the SHA1 (32965fa7) has not changed since last install.
#>   Use `force = TRUE` to force installation
devtools::install_github("mkarikom/mtSCRABBLE")
#> Skipping install of 'mtSCRABBLE' from a github remote, the SHA1 (07a86c84) has not changed since last install.
#>   Use `force = TRUE` to force installation
install.packages("foreach")
#> Installing package into '/usr/local/lib/R/site-library'
#> (as 'lib' is unspecified)

Sys.setenv(JULIA_HOME="/usr/local/julia-1.7.2/bin")
install.packages("JuliaCall")
#> Installing package into '/usr/local/lib/R/site-library'
#> (as 'lib' is unspecified)
library(JuliaCall)
julia_setup(JULIA_HOME = Sys.getenv("JULIA_HOME"),verbose=TRUE,rebuild = TRUE,install=FALSE)
```

### Package

``` r
install_github("mkarikom/DURIAN")
#> Skipping install of 'DURIAN' from a github remote, the SHA1 (eab75305) has not changed since last install.
#>   Use `force = TRUE` to force installation
```

## Module Selection

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

## Getting Started

<div>

Check out basic usage of DURIAN running and visualizing imputation of
Human single-cell data in `vignette("basic_usage")`.

</div>

##### Load the package and data

``` r
library(DURIAN)
data(c("C","B","pDataC"))
```

<!-- ##### Preprocess the data -->
<!-- ```{r, cache=TRUE} -->
<!-- library(Seurat) -->
<!-- seur = CreateSeuratObject(counts=C) -->
<!-- seur = NormalizeData(seur) -->
<!-- genes = VariableFeatures(FindVariableFeatures(seur, selection.method = "vst", nfeatures = 1500)) -->
<!-- comgenes = intersect(genes,rownames(B)) -->
<!-- C = subsetsc(scremoutlier(C),geneids=comgenes,return_obj=TRUE,nsd=3) -->
<!-- pDataC = pDataC[colnames(C),] -->
<!-- ``` -->

##### Run imputation on the single-cell data, using the bulk data for supervision.

``` r
impresult_list=run_durian(
      scrabble_parameters = c(1,1e-6,1e-4),
      nEM = 5,
      scdata = C,
      metadata = pDataC,
      bulkdata = B,
      deconv_method = "MuSiC",
      nIter_outer = 10,
      nIter_inner = 10,
      nSDCIters = 500000,
      DECONVGENETHRESH=-0.01,
      SCRGENETHRESH=-0.01,
      outerStats = FALSE,
      durianEps=1e-3,
      saveImputationLog = FALSE,
      saveDeconvolutionLog = FALSE,
      saveImputedStep=FALSE)
  impresult = impresult_list[["C"]]
```

##### Construct a low-dimensional UMAP embedding from imputed and original data

``` r
library(umap)
library(ggplot2)
library(reshape2)
umap_imputed = umap(t(impresult))
umap_orig = umap(t(as.matrix(C)))
imputed_df = cbind(umap_imputed$layout,pDataC)
imputed_df$status = "Imputed"
orig_df = cbind(umap_orig$layout,pDataC)
orig_df$status = "Unimputed"
df = rbind(imputed_df,orig_df)
colnames(df) = c("UMAP1","UMAP2","cellID","cellType","sampleID","status")
df$status = factor(df$status,levels=c("Unimputed","Imputed"))
```

##### Plot the original and imputed data

``` r
ggplot(df,aes(x=UMAP1, y=UMAP2,color=cellType)) + 
      geom_point(size=1)+
      facet_grid(~status,scales="free") + theme_bw()
```

![](man/figures/unnamed-chunk-7-1.svg)<!-- -->
