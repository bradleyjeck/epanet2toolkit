#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************

context("get link index")
test_that("no crash calling on closed toolkit",{
  expect_error( x <- ENgetlinkindex("10") ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  lidx <- 	ENgetlinkindex("20")
  ENclose()
  expect_equal(lidx,1)
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(nidx <- ENgetlinkindex(c("20","40","50")))
  ENclose()
})
test_that("get error 204 on no index",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetlinkindex("1"),"204")
  ENclose()
})


context("get link ID")
test_that("no crash calling on closed toolkit",{
  expect_error( x <- ENgetlinkid(1) ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  lid <- 	ENgetlinkid(1)
  ENclose()
  expect_equal(lid,"20")
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(lid <- ENgetlinkid(c(1,2,3)))
  ENclose()
})
test_that("get error 204 on no ID",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetlinkid(211),"204")
  ENclose()
})


context("get link type")
test_that("no crash calling on closed toolkit",{
  expect_error( x <- ENgetlinktype(1) ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  ltyp <- 	ENgetlinktype(1)
  ENclose()
  expect_equal(ltyp, 1)
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ltyp <- ENgetlinktype(c(1,2,3)))
  ENclose()
})
test_that("get error 204 on no index",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetlinktype(550),"204")
  ENclose()
})


context("get link nodes")
test_that("no crash calling on closed toolkit",{
  expect_error( x <- ENgetlinknodes(1) ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  lnod <- 	ENgetlinknodes(1)
  ENclose()
  expect_equal(lnod, c(97,3))
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(lnod <- ENgetlinknodes(c(1,2,3)))
  ENclose()
})
test_that("get error 204 on no index",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetlinknodes(333),"204")
  ENclose()
})


context("get link value")
test_that("no crash calling on closed toolkit",{
  expect_error(x <- ENgetlinkvalue(1,1) )
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  x <- 	ENgetlinkvalue(1,0)
  ENclose()
  expect_equal(x, 99, tolerance=1e-6)
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(x <-	ENgetlinkvalue(5,0:3))
  ENclose()
})
test_that("get error 204 on no link",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetlinkvalue(120,1),"204")
  ENclose()
})
test_that("get error on wrong code",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetlinkvalue(1,100))
  ENclose()
})


context("set link value")
test_that("no crash calling on closed toolkit",{
  expect_error( ENsetlinkvalue(1,0,100) )
})
test_that("works on single input",{
  ENopen("Net3.inp","Net3.rpt")
  ENsetlinkvalue(1,0,105)		
  x <- ENgetlinkvalue(1,0)
  ENclose()
  expect_equal(x,105, tolerance = 1e-6)
})
test_that("error on multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error( ENsetlinkvalue(0, 3:4, c(133.5,125.5))		)
  ENclose()
})
test_that("get error 204 on undefined link",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetlinkvalue(120,0,131.4),"204")
  ENclose()
})
test_that("get error on wrong parameter code",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetlinkvalue(1,100,1.5))
  ENclose()
})
test_that("returns NULL invisibly on success",{
  ENopen("Net3.inp","Net3.rpt")
  x <- withVisible( ENsetlinkvalue(1,0,105))
  ENclose()
  expect_null(x$value)
  expect_false(x$visible)
})
