


context("vertex crud")
test_that("ENgetvertexcount",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("link22-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile, "")

  nv5 <- ENgetvertexcount(5)
  expect_equal(nv5,0)

  ENclose()

  file.remove(rptFile)

})

test_that("Create vertex",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("link22-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile, "")

  ENsetvertices(5, 22, 33)

  nv5 <- ENgetvertexcount(5)
  expect_equal(nv5,1)

  v5 <- ENgetvertex(5,1)

  expect_equal( as.integer(v5$x), 22)
  expect_equal( as.integer(v5$y), 33)

  ENclose()
  file.remove(rptFile)

})

test_that("Create vertices",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("link22-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile, "")

  ENsetvertices(5, c(22,44), c(33,55))

  nv5 <- ENgetvertexcount(5)
  expect_equal(nv5,2)

  v5 <- ENgetvertex(5,1)
  expect_equal( as.integer(v5$x), 22)
  expect_equal( as.integer(v5$y), 33)

  v52 <- ENgetvertex(5,2)
  expect_equal( as.integer(v52$x), 44)
  expect_equal( as.integer(v52$y), 55)

  ENclose()
  file.remove(rptFile)

})