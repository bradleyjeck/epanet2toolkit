#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************



context("Get option")

test_that("no crash calling on closed toolkit",{
			expect_false( getOpenflag() )
			expect_error( x <- ENgetoption(0) ) 
		})

test_that("works for single character input",{
			ENopen("Net1.inp", "Net1.rpt")
			opt <- ENgetoption("EN_TRIALS") 
			expect_equal( 40, opt)
			ENclose()	
		})

test_that("works for integer input",{
			ENopen("Net1.inp", "Net1.rpt")
			opt <- ENgetoption(as.integer(0)) 
			expect_equal( 40, opt)
			ENclose()	
			
		})

test_that("works for numeric input",{
			ENopen("Net1.inp", "Net1.rpt")
			opt <- ENgetoption(0) 
			expect_equal( 40, opt)
			ENclose()	
		})

test_that("gives error on multiple input",{
			ENopen("Net1.inp", "Net1.rpt")
			expect_error( ENgetoption(c(0,1))) 
			ENclose()	
		})

test_that("returns error 251",{ 
			
			ENopen("Net1.inp", "Net1.rpt")
			expect_error(ENgetoption(40) , "251")
			ENclose()	
			
		})


context("Set option")

test_that("no crash calling on closed toolkit",{
			expect_false( getOpenflag() )
			expect_error( x <- ENsetoption(0,33) ) 
		})

test_that("works for character input",{
			ENopen("Net1.inp", "Net1.rpt")
			ENsetoption("EN_TRIALS", 33) 
			opt <- ENgetoption("EN_TRIALS")
			expect_equal( 33, opt)
			ENclose()	
		})

test_that("works for integer input",{
			ENopen("Net1.inp", "Net1.rpt")
			ENsetoption(as.integer(0), 33) 
			opt <- ENgetoption(as.integer(0)) 
			expect_equal( 33, opt)
			ENclose()	
			
		})

test_that("works for numeric input",{
			ENopen("Net1.inp", "Net1.rpt")
			ENsetoption(0, 33) 
			opt <- ENgetoption(0) 
			expect_equal( 33, opt)
			ENclose()	
		})

test_that("gives error on multiple input",{
			ENopen("Net1.inp", "Net1.rpt")
			expect_error( ENsetoption(c(0,1),c(3,4))) 
			ENclose()	
		})

test_that("returns error 251",{ 
			
			ENopen("Net1.inp", "Net1.rpt")
			expect_error(ENsetoption(40,40) , "251")
			ENclose()	
		})

test_that("returns NULL invisibly on success",{
			ENopen("Net1.inp", "Net1.rpt")
			x <- withVisible(ENsetoption(0, 33) )
			ENclose()	
			expect_null(x$value)	
			expect_false(x$visible)
		})


context("get flow units")
test_that("no crash calling on closed toolkit",{
			expect_error(	x <- ENgetflowunits() )
		})
test_that("works",{
			
			
			ENopen("Net1.inp","Net1.rpt")  
			x <- ENgetflowunits()
			ENclose()
			
			y <- 1 
			names(y) <- "EN_GPM"
			expect_equal(x,y )
		})

