#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Bradley J Eck
#
#  
#****************************************/

context("ENclose")

test_that("func exists",{
  expect_true( is.loaded("enClose"))
})
test_that("func works",{
	    ENopen("Net1.inp","n1.rpt","")
		 ENclose() 
		 expect_false(getOpenflag())
        # clean-up
		file.remove("n1.rpt")
})
test_that("warns not crashes when already closed",{
			
			expect_false(getOpenflag())
			expect_warning(ENclose())
			
		}) 

test_that("returns NULL invisibly on Success",{
	    ENopen("Net1.inp","n1.rpt","")
		x <- withVisible( ENclose() ) 
		expect_null( x$value)
		expect_false( x$visible)
			
		})

