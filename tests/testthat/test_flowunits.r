#*****************************************
#
# (C) Copyright IBM Corp. 2020
# Author: Bradley J Eck 
#
#*****************************************/


context("flow units") 

test_that("behavior calling on closed toolkit",{
  expect_warning( flowunits <- ENgetflowunits() )  
  expect_true( is.null(flowunits) ) 
  
}) 

test_that("basic usage",{
 
  ENopen("Net1.inp", "Net1.rpt")
  units <- ENgetflowunits()
  expect_equal( unname(units),  1 ) 
  ENclose()


}) 

test_that("works",{
			
			
			ENopen("Net1.inp","Net1.rpt")  
			x <- ENgetflowunits()
			ENclose()
			
			y <- 1 
			names(y) <- "EN_GPM"
			expect_equal(x,y )
		})

