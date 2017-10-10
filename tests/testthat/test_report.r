#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#****************************************/

context("report")
test_that("no crash calling on closed toolkit",{
  expect_false( getOpenflag() )
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
