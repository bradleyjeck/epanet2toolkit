

context("ENgetdemandmodel")
test_that("get demand model",{

  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("node-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile, "")

  dmdmdl <- ENgetdemandmodel()
  expect_true( is.list(dmdmdl))

  ENclose()

  file.remove(rptFile)
  
})