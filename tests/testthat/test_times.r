#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************


context("Get time param")

test_that("no crash calling on closed toolkit",{
			expect_error( x <- ENgettimeparam(1) ) 
		})

test_that("works for single character input",{
			ENopen("Net1.inp", "Net1.rpt")
			dur <- ENgettimeparam("EN_DURATION")
			expect_equal( 86400, dur)
			step <- ENgettimeparam("EN_HYDSTEP")
			expect_equal( 3600, step)
			ENclose()	
		})

test_that("works for integer input",{
			ENopen("Net1.inp", "Net1.rpt")
			dur <- ENgettimeparam(0)
			expect_equal( 86400, dur)
			step <- ENgettimeparam(1)
			expect_equal( 3600, step)
			ENclose()	
			
		})

test_that("returns error 251",{ 
			
			ENopen("Net1.inp", "Net1.rpt")
			expect_error(ENgettimeparam(40) , "251")
			ENclose()	
			
		})

test_that("warns if time param is too large for integers in R",{
			ENopen("Net1-longduration.inp", "Net1-ld.rpt")
			expect_warning( dur <- ENgettimeparam("EN_DURATION"))
			ENclose()

		})


context("Set time param")

test_that("no crash calling on closed toolkit",{
		expect_error( x <- ENsettimeparam(1,1800) ) 
		})

test_that("works for character inputs",{
			ENopen("Net1.inp", "Net1.rpt")
			ENsettimeparam("EN_DURATION", "7777")
			dur <- ENgettimeparam(0 ) 
			ENclose()	
			expect_equal( 7777, dur)
		})

test_that("works for numeric inputs",{
			ENopen("Net1.inp", "Net1.rpt")
			ENsettimeparam(0,7777 )
			dur <- ENgettimeparam(0 ) 
			ENclose()	
			expect_equal( 7777, dur)
		})
test_that("works for integer inputs",{
			ENopen("Net1.inp", "Net1.rpt")
			ENsettimeparam(as.integer(0) , as.integer(7777 )) 
			dur <- ENgettimeparam(0 ) 
			ENclose()	
			expect_equal( 7777, dur)
		})

test_that("reterns NULL invisibly on success",{
			ENopen("Net1.inp", "Net1.rpt")
			x <- withVisible( ENsettimeparam(0,7777 ))
			ENclose()	
			expect_null( x$value )
			expect_false( x$visible )
			
		})

test_that("returns error 202",{ 
			
			ENopen("Net1.inp", "Net1.rpt")
			expect_error(ENsettimeparam(1,-100) )
			ENclose()	
			
		})
