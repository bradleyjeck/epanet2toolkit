#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************

context("get coord")
test_that("no crash calling on closed toolkit",{
  expect_false( getOpenflag() )
  expect_error( x <- ENgetcoord(1) ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  ix <- ENgetnodeindex("15")
  expect_true( is.numeric( ix))
  xy <- 	ENgetcoord(ix)
  ENclose()
  expect_equal(xy,  c(x=38.68, y=23.76))           
})
test_that("rejcects char input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetcoord("15"))
  ENclose()
})
			
test_that("get error 203 on no index",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetcoord(155),"203")
  ENclose()
})

context("set coord")
test_that("no crash calling on closed toolkit",{
  expect_false( getOpenflag() )
  expect_error( x <- ENsetcoord(1) ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  ix <- ENgetnodeindex("15")
  ENsetcoord(ix, 39.98, 23.23)
  xy <- 	ENgetcoord(ix)
  ENclose()
  expect_equal(xy,  c(x=39.98, y=23.23))           
})
test_that("rejcects char input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetcoord("15", 1,2))
  ENclose()
})
test_that("get error 203 on no index",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetcoord(155, 1,2),"203")
  ENclose()
})

