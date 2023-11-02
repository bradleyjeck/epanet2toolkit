

context("ENgetdemandmodel")
test_that("get demand model",{

  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("node-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile)

  dmdmdl <- ENgetdemandmodel()
  expect_true( is.list(dmdmdl))

  ENclose()

  file.remove(rptFile)
})

context("ENsetdemandmodel")
test_that("set demand model",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("node-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile)

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



context("Net3 node 40 existing demand")
test_that("base demand",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("node-tests-", suffix, ".rpt")
  ENopen("Net3.inp", rptFile)
  nidx <- ENgetnodeindex("40")

  bdmd <- ENgetbasedemand(nodeindex = nidx, demand_index = 1)
  expect_equal( as.integer(bdmd), 0)

  dname <- ENgetdemandname(nidx)
  expect_equal(dname, "")

  didx <- ENgetdemandindex(nidx, "")
  expect_equal(didx, 1)

  ENsetbasedemand(nidx, 1, 3)
  bdmd3 <- ENgetbasedemand(nidx)
  expect_equal(as.integer(bdmd3), 3)

  ENclose()

  file.remove(rptFile)
})

context("Net3 node 40 adding demand")
test_that("add demand",{
  suffix <- paste0(sample(letters, 4), collapse="")
  rptFile <- paste0("node-tests-", suffix, ".rpt")
  ENopen("Net3.inp", rptFile)
  nidx <- ENgetnodeindex("40")
  x <- ENadddemand(nodeindex=nidx, base_demand=123, demand_pattern=3, demand_name="test")
  expect_null(x)

  num <- ENgetnumdemands(nidx)
  expect_equal(num,2)

  didx <- ENgetdemandindex(nidx, "test")
  expect_equal(didx, 2)
  dname <- ENgetdemandname(nidx, didx)
  expect_equal(dname, "test")

  ENsetdemandname(nidx, didx, suffix)
  dname2 <- ENgetdemandname(nidx, didx)
  expect_equal( dname2, suffix)

  didx2 <- ENgetdemandindex(nidx, suffix)
  expect_equal(didx2, 2)

  ENdeletedemand(nidx, didx)
  num2 <- ENgetnumdemands(nidx)
  expect_equal(num2,1)

  ENclose()
  file.remove(rptFile)
})

context("demand patterns")
test_that("get set demand patterns",{

  suffix <- paste0(sample(letters, 4), collapse="")
  rptFile <- paste0("node-tests-", suffix, ".rpt")
  ENopen("Net3.inp", rptFile)
  
  # node 35 has demand pattern 4
  p4idx <- ENgetpatternindex("4")
  n35idx <- ENgetnodeindex("35") 
  n35pat <- ENgetdemandpattern(n35idx)
  expect_equal(n35pat, p4idx)
  

  # assign pattern 3 to node 20
  n20idx <- ENgetnodeindex("20")
  p3idx <- ENgetpatternindex("3")
  ENsetdemandpattern(n20idx, demand_index=1, p3idx)
  x <- ENgetdemandpattern(n20idx)
  expect_equal(x,p3idx)

  ENclose()

  file.remove(rptFile)
})