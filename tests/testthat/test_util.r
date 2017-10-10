#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Bradley J Eck
#
#  
#****************************************/



context("Openflag")
test_that("func loads",{
			expect_true( is.loaded("RgetOpenflag"))
		})
test_that("func works w good context",{
			
			ENopen("Net1.inp", "Net1.rpt", "")
			expect_true(getOpenflag())
			ENclose()
		})

test_that("verify false",{
			expect_false(getOpenflag())
		})

test_that("verify true",{
			
			ENopen("Net1.inp", "Net1.rpt", "")
			expect_true(getOpenflag())
			ENclose()
		})

context("long stored as char to int or char")

test_that("can return int",{
			
			x <- charlong_to_int_or_char( "123")
			expect_equal(x,123)
			
		})

test_that("can return char",{
			
			x <- charlong_to_int_or_char( "12345678901")
			expect_equal(x,"12345678901")
			
		})


