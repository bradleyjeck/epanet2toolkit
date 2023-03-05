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


context("ENresetreport")
test_that("no crash calling on closed toolkit",{
  expect_silent( x <- ENresetreport() )
})

context("ENsetreport")
test_that("no crash calling on closed toolkit",{
  expect_silent( x <- ENsetreport("links all") )
  ENclose()
})
test_that("setreport",{
  rptFile <- "Net1-rpt-linksall.test"
  ENopen("Net1.inp",rptFile , "")
  ENsetreport("Links All")
  ENsolveH()
  ENsolveQ()
  ENreport()
  ENclose()
  # confirm that links end up in the report
  rpt <- epanetReader::read.rpt( rptFile )
  expect_true( dim(rpt$linkResults)[1] > 10)
  # clean up 
  file.remove(rptFile)
})

context("ENsetstatusreport")
test_that("ENsetstatusreport",{
  # full status report
  fullRpt <- "Net1-rpt-status-full.test"
  ENopen("Net1.inp", fullRpt, "")
  ENsetstatusreport("EN_FULL_REPORT")
  ENsolveH()
  ENsolveQ()
  ENreport()
  ENclose()
  # no status report
  noRpt <- "Net1-rpt-status-none.test"
  ENopen("Net1.inp", noRpt, "")
  ENsetstatusreport("EN_NO_REPORT")
  ENsolveH()
  ENsolveQ()
  ENreport()
  ENclose()
  # confirm FULL report is longer than NO report
  expect_true(  length(readLines(fullRpt)) >
                length(readLines(noRpt)),
                "full status report is longer than no report")
  # clean up 
  file.remove(fullRpt)
  file.remove(noRpt)
  
})