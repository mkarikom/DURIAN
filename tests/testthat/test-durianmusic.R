test_that("imputation works with nnls (music) deconvolution", {
  C = read.csv("data/C.csv",row.names=1)
  B = read.csv("data/B.csv",row.names=1)
  pDataC = read.csv("data/pDataC.csv",row.names=1)
  trueC = read.csv("data/trueC.csv",row.names=1)
  trueP = read.csv("data/trueP.csv",row.names=1)
  impresult_list=run_durian(
      path = "testoutput",
      scrabble_parameters = c(1,1e-6,1e-4),
      nEM = 3,
      scdata = C,
      metadata = pDataC,
      bulkdata = B,
      deconv_method = "MuSiC",
      imputebenchmark = trueC,
      deconvbenchmark = trueP,
      nIter_outer = 5,
      nIter_inner = 5,
      nSDCIters = 500000,
      DECONVGENETHRESH=-0.01,
      SCRGENETHRESH=-0.01,
      outerStats = FALSE,
      durianEps=1e-3,
      saveImputationLog = FALSE,
      saveDeconvolutionLog = FALSE,
      saveImputedStep=FALSE)
  impresult = impresult_list[["C"]]
  expect_true(sqrt(mean((as.matrix(impresult)-as.matrix(trueC))^2)) < sqrt(mean((as.matrix(C)-as.matrix(trueC))^2)))
})
