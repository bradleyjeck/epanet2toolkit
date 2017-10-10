#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************

context("ENopen")

test_that("open w good inputs",{
		expect_silent(  ENopen("Net1.inp", "Net1.rpt", ""))
		ENclose()
})

test_that("warn if it's already open",{
			
		ENopen("Net1.inp", "Net1.rpt", "")	
		expect_true(getOpenflag())
		expect_warning(ENopen("Net3.inp", "Net3.rpt", "")	)
		expect_true(getOpenflag())
		ENclose()
		expect_false(getOpenflag())
			
		})

test_that("returns NULL invisibly on success",{
		x <- withVisible( ENopen("Net1.inp", "Net1.rpt", "")	)
		ENclose()
		
		expect_null( x$value)
		
		expect_false( x$visible)
			
		})

test_that("returns error code",{
			
			expect_error( ENopen("Net55.inp", "Net55.rpt"), "302")
			
		})