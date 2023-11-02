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
  ENclose()
  file.remove("Net1-rpt.test")
})


context("ENresetreport")
test_that("no crash calling on closed toolkit",{
  expect_error( x <- ENresetreport() )
})

context("ENsetreport")
test_that("no crash calling on closed toolkit",{
  expect_error( x <- ENsetreport("links all") )
})
test_that("setreport",{
  rptFile <- "Net1-rpt-linksall.test"
  outFile <- "Net1-out-linksall.test"
  ENopen("Net1.inp",rptFile,outFile)
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
  file.remove(outFile)
})

context("ENsetstatusreport")
test_that("ENsetstatusreport",{
  # full status report
  fullRpt <- "Net1-rpt-status-full.test"
  fullOut <- "Net1-out-status-full.test"
  ENopen("Net1.inp", fullRpt, fullOut)
  ENsetstatusreport("EN_FULL_REPORT")
  ENsolveH()
  ENsolveQ()
  ENreport()
  ENclose()
  # no status report
  noRpt <- "Net1-rpt-status-none.test"
  noOut <- "Net1-out-status-none.test"
  ENopen("Net1.inp", noRpt, noOut)
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
  file.remove(fullOut)
  file.remove(noRpt)
  file.remove(noOut)
  
})

context("ENgeterror")
test_that("gets err msg",{
    msg <- ENgeterror(200)
    expect_false( is.na(msg))
})

context("ENgetstatistic")
test_that("stats work",{
  ENopen("Net1.inp", "Net1-stats-test.rpt")
  ENopenH()
  ENinitH(11)
  ENrunH()
  ENnextH()

  stat <- "EN_ITERATIONS"
  val <- ENgetstatistic(stat)
  expect_true(as.integer(val) > 0)

  stat <- "EN_RELATIVEERROR"
  val <- ENgetstatistic(stat)
  expect_true( val < 1 )

  stat <- "EN_MAXHEADERROR"
  val <- ENgetstatistic(stat)
  expect_true( val < 1 )

  stat <- "EN_MAXFLOWCHANGE"
  val <- ENgetstatistic(stat)
  expect_true( val < 1 )

  stat <- "EN_MASSBALANCE"
  val <- ENgetstatistic(stat)
  expect_true( val < 1 )

  stat <- "EN_DEFICIENTNODES"
  val <- ENgetstatistic(stat)
  expect_true( val < 1 )

  stat <- "EN_DEMANDREDUCTION"
  val <- ENgetstatistic(stat)
  expect_true( val < 1 )

  ENclose()
  file.remove("Net1-stats-test.rpt")
})

context("ENgetresultindex")
test_that("index matches",{

  rptFile <- "Net1-indexcheck.rpt"
  outFile <- "Net1-indexcheck.out"
  ENopen("Net1.inp", rptFile, outFile)
  ENsolveH()
  ENsolveQ()
  ENreport()

  nix <- 3
  nid <- ENgetnodeid(nix)
  rix <- ENgetresultindex("EN_NODE", nix)
  
  ENclose()

  # supporess warning about missing link results
  rpt <- suppressWarnings( epanetReader::read.rpt(rptFile))
  expect_equal( rpt$nodeResults$ID[rix], nid, 
                "node ID in report file matches rix")
  
  file.remove(rptFile)
  file.remove(outFile)
})
