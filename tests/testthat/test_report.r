#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Ernesto Arandia & Bradley J Eck
#
#****************************************/

context("ENreport")
test_that("no crash calling on closed toolkit",{
  expect_error( x <- ENreport() ) 
})
test_that("works",{

     ENopen("Net1.inp", "Net1-rpt.test", "Net1-rt.bin")
     ENsetnodevalue( 1, "EN_ELEVATION",  500)
     ENsolveH()
     ENsolveQ()
     ENreport()
     ENclose()

     expect_true( file.exists("Net1-rpt.test"))
 
     file.remove("Net1-rpt.test")
     file.remove("Net1-rt.bin")
     
})

context("ENcopyreport")

test_that("no crash calling on closed toolkit",{
  expect_error( x <- ENcopyreport() ) 
})

test_that("writes report on open project",{

  ENopen("Net1.inp", "Net1-rpt.test", "Net1-rt.bin")
  t = NULL
  ENopenH()
  ENinitH(11)
  t <- c(t,ENrunH())
  tstep <- ENnextH()
  ENcopyreport("temp.rpt")
  ENcloseH()
  ENclose()

  expect_true(file.exists("temp.rpt"))
  file.remove("temp.rpt")
  file.remove("Net1-rpt.test")

})


context("ENclearreport")
test_that("no crash calling on closed toolkit",{
  expect_silent( x <- ENclearreport() ) 
})


test_that("writes report on open project",{
  ENopen("Net1.inp", "Net1-rpt.test", "Net1-rt.bin")
  ENsolveH()
  ENsolveQ()
  ENreport()
  x <- length(readLines("Net1-rpt.test", warn=FALSE))
  ENclearreport()
  ENreport()
  y <- length(readLines("Net1-rpt.test", warn=FALSE))
  expect_true( x > y)
  file.remove("Net1-rpt.test")
})