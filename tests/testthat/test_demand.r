

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

context("ENsetdemandmodel")
test_that("set demand model",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("node-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile, "")

  ENsetdemandmodel(model="EN_PDA", pmin=10, preq=25, pexp=1.1)

  dmdmdl <- ENgetdemandmodel()
  expect_true(is.list(dmdmdl))
  expect_equal(dmdmdl$model, "EN_PDA")
  expect_equal(as.integer(dmdmdl$pmin), 10)
  expect_equal(as.integer(dmdmdl$preq), 25)
  expect_true(dmdmdl$pexp > 1.08)

  ENclose()

  file.remove(rptFile)
})