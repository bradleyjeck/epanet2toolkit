#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************




context("get node index")
test_that("no crash calling on closed toolkit",{
  expect_false( getOpenflag() )
  expect_error( x <- ENgetnodeindex("10") ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  nidx <- 	ENgetnodeindex("10")
  ENclose()
  expect_equal(nidx,1)
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(nidx <- ENgetnodeindex(c("10","15","20")))
  ENclose()
})
test_that("get error 203 on no index",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetnodeindex("11"),"203")
  ENclose()
})


context("get node ID")
test_that("no crash calling on closed toolkit",{
  expect_false( getOpenflag() )
  expect_error( x <- ENgetnodeid(1) ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  nid <- 	ENgetnodeid(1)
  ENclose()
  expect_equal(nid,"10")
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(nid <- ENgetnodeid(c(1,2,3)))
  ENclose()
})
test_that("get error 203 on no ID",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetnodeid(550),"203")
  ENclose()
})


context("get node type")
test_that("no crash calling on closed toolkit",{
  expect_false( getOpenflag() )
  expect_error( x <- ENgetnodetype(1) ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  ntyp <- 	ENgetnodetype(1)
  ENclose()
  expect_equal(ntyp, 0)
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ntyp <- ENgetnodetype(c(1,2,3)))
  ENclose()
})
test_that("get error 203 on no index",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetnodetype(550),"203")
  ENclose()
})


context("get node value")
test_that("no crash calling on closed toolkit",{
  expect_false( getOpenflag() )
  expect_error(x <- ENgetnodevalue(1,1) )
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  x <- 	ENgetnodevalue(5,0)
  ENclose()
  expect_equal(x, 131.9, tolerance=1e-5)
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(x <-	ENgetnodevalue(5,0:3))
  ENclose()
})
test_that("get error 205 on no node",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetnodevalue(120,1),"203")
  ENclose()
})
test_that("get error 251 on wrong code",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetnodevalue(1,100))
  ENclose()
})


context("set node value")
test_that("no crash calling on closed toolkit",{
  expect_false( getOpenflag() )
  expect_error( ENsetnodevalue(1,0,120) )
})
test_that("works on single input",{
  ENopen("Net3.inp","Net3.rpt")
  ENsetnodevalue(5,0,134.5)		
  x <- ENgetnodevalue(5,0)
  ENclose()
  expect_equal(x,134.5, tolerance = 1e-6)
})
test_that("error on multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error( ENsetnodevalue(0, 3:4, c(133.5,125.5))		)
  ENclose()
})
test_that("get error 205 on no pattern",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetnodevalue(120,0,131.4),"203")
  ENclose()
})
test_that("get error 251 on wrong parameter code",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetnodevalue(1,100,1.5),"251")
  ENclose()
})
test_that("returns NULL invisibly on success",{
  ENopen("Net3.inp","Net3.rpt")
  x <- withVisible(ENsetnodevalue(5,0,134.5))
  ENclose()
  expect_null(x$value)
  expect_false(x$visible)
})
