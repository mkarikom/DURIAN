#' Single-cell sequencing of normal skin from human atopic dermatitis patients
#'
#' Approximately 500 cells, randomly sub-sampled from the data. 
#'
#' @format A data frame with 5991 genes and 472 cells:
#' @source \url{https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE147424}
"C"
# corresponding to HeNL.sense0.1.cpm.sub5000;SuarezNL.sense0.1.cpm
# target = as.integer(Sys.getenv("SUBTARGETSIZE")) # 1500
# mincells = as.integer(Sys.getenv("SUBMINCELLS")) # 5
# generate = as.numeric(Sys.getenv("SUBGENERATE"))
# set.seed(simrep)
# sampn = min(ncol(C),target)
# C = as.data.frame(t(as.data.frame(t(C)) %>% sample_n(sampn)))
# C = subsetsc(scremoutlier(C),generate=generate,return_obj=TRUE,nsd=3)
# pDataC = pDataC[colnames(C),]

#' Normal skin from human atopic dermatitis patients
#'
#' Labels corresponding to re-clustered cells in dataset `C`, following DESeq2-based differential marker-selection based on disease, given bulk/pseudobulk modality where bulk data are the normal and disease tissue samples from \href{https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE65832}{Suarez-Farinas 2015 et. al.} and pseudobulk data are the normal and disease cells from \href{https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE147424}{He 2020 et. al.}.  Differentially-expressed genes were selected based on adjusted p-value <= 1e-2.
#'
#' @format A data frame with 5991 genes and 472 cells:
#' @source \url{https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE147424}
"pDataC"

#' Bulk sequencing of normal skin from human atopic dermatitis patients
#'
#' Normal skin tissue from 20 patients.
#'
#' @format A data frame with 6000 genes and 20 donors:
#' @source \url{https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE65832}
"B"