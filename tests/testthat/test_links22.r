context("links crud")
test_that("link crud",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("link22-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile)

  #Create
  lidx <- ENaddlink("new", "EN_CVPIPE","12","22")
  expect_true(lidx>0)
  #Read
  new_link_nodes <- ENgetlinknodes(lidx)
  n1idx <- ENgetnodeindex("12")
  expect_equal(n1idx, new_link_nodes[[1]])
  n2idx <- ENgetnodeindex("22")
  expect_equal(n2idx, new_link_nodes[[2]])
  # Update
  ENsetlinkid(lidx,"newnew")
  id <- ENgetlinkid(lidx)
  expect_equal("newnew", id)

  ENsetlinktype(lidx,"EN_PIPE")
  lt <- ENgetlinktype(lidx)
  expect_equal(lt,lookup_enum_value(linkTypes,"EN_PIPE"))

  ENsetlinknodes(lidx,2,7)
  updated_link_nodes <- ENgetlinknodes(lidx)
  expect_equal(2, updated_link_nodes[[1]])
  expect_equal(7, updated_link_nodes[[2]])

  # Delete
  ENdeletelink(lidx)
  #expect_error( ENgetlinknodes(lidx))
  


  ENclose()

  file.remove(rptFile)

})


context("vertex crud")
test_that("ENgetvertexcount",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("link22-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile)

  nv5 <- ENgetvertexcount(5)
  expect_equal(nv5,0)

  ENclose()

  file.remove(rptFile)

})

test_that("Create vertex",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("link22-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile)

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
  ENopen("Net1.inp", rptFile)

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