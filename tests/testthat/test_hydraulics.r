#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Bradley J Eck and Ernesto Arandia
#
#*****************************************/



context("ENsolveH")
test_that("func works",{
  ENopen("Net1.inp", "Net1.rpt")
  expect_silent( ENsolveH()) 
  ENclose()
})
test_that("returns null invisbly on success",{
  ENopen("Net1.inp", "Net1.rpt")
  x <- withVisible( ENsolveH() ) 
  ENclose()
  
  expect_null( x$value)
  expect_false( x$visible)
			
		})


# context("ENsaveH")
# test_that("func works",{
#   ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
#   ENsolveH()
#    expect_silent( ENsaveH()) 
#   ENclose()
# })
# 
# test_that("returns null invisbly on success",{
#   ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
#   ENsolveH()
#   x <- withVisible( ENsaveH() ) 
#   ENclose()
#   
#   expect_null( x$value)
#   expect_false( x$visible)
# 			
# 		})


context("ENopenH")
test_that("func works",{
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
   expect_silent( ENopenH())
  ENclose()
})

test_that("no crash calling twice",{
  ENopen("Net1.inp", "Net1.rpt")	
    expect_silent(ENopenH())
    expect_silent(ENopenH())
    expect_silent(ENcloseH())
  ENclose()
})
test_that("returns null invisbly on success",{
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  x <- withVisible( ENopenH() ) 
  ENclose()
  expect_null( x$value)
  expect_false( x$visible)
})


context("ENinitH")
test_that("func works w integer input",{
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  ENopenH()
  expect_silent( ENinitH( as.integer(11)))
  ENcloseH()
  ENclose()
})
test_that("func works w numeric input",{
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  ENopenH()
  expect_silent( ENinitH( 11))
  ENclose()
})
test_that("returns null invisbly on success",{
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  ENopenH()
  x <- withVisible( ENinitH( as.integer(11) ) ) 
  ENclose()
  expect_null( x$value)
  expect_false( x$visible)
})


context("ENrunH")
test_that("func gives a warning when hydraulics are not open", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
    expect_error(ENrunH(), "103")
  ENclose()
})
test_that("func warns of lack of hydraulic initialization", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
    ENopenH()
      expect_warning(x <- ENrunH(), "6")
    ENcloseH()
  ENclose()
})
test_that("func works normally", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  ENopenH()
    expect_silent(ENinitH(11))
    expect_silent(x <- ENrunH())
  ENcloseH()
  ENclose()
  expect_equal(x, 0)
})


context("ENnextH")
test_that("func gives a warning when hydraulics are not open", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
    expect_error(ENnextH(), "103")
  ENclose()
})
test_that("func works normally", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  ENopenH()
    ENinitH(11)
    ENrunH()
    expect_silent(x <- ENnextH())
  ENcloseH()
  ENclose()
  expect_equal(x, 3600)
})
test_that("func works normally with loop", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  t = NULL
  ENopenH()
    ENinitH(11)
    repeat {
      t <- c(t,ENrunH())
      tstep <- ENnextH()
      if (tstep == 0) {
        break
      }
    }
  ENcloseH()
  ENclose()
  expect_equal(t[c(1,7,27)], c(0,21600,86400))
})


context("ENcloseH")
test_that("func gives an error when hydraulics are not open", {
  ENopen("Net1.inp", "Net1.rpt", "Net1.bin")
  expect_silent(ENcloseH())
  ENclose()
})

context("ENsavehydfile")
test_that("func exists",{
   expect_true(is.loaded("RENsavehydfile"))
})
test_that("file saves",{
  ENopen("Net1.inp", "Net1.rpt")
  ENsolveH()
  hydfile <- "net1.hyd"
  ENsavehydfile(hydfile)
  ENclose()
  expect_true( file.exists(hydfile))

  # clean-up from the test
  file.remove(hydfile)
})
context("ENusehydfile")
test_that("func exists",{
   expect_true(is.loaded("RENusehydfile"))
})
test_that("file loads",{
  # create hydraulics file
  ENopen("Net1.inp", "Net1.rpt")
  ENsolveH()
  hydfile <- "net1.hyd"
  ENsavehydfile(hydfile)
  ENclose()
  expect_true( file.exists(hydfile))

  # now open the network again and load the file
  ENopen("Net1.inp", "Net1.rpt")
  expect_silent( ENusehydfile(hydfile))
  ENclose()


  # clean-up from the test
  file.remove(hydfile)
})