#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************


context("error codes")
test_that("verify no error",{
		
			x <- check_epanet_error( as.integer(0))
                       expect_true( is.null(x))
})
test_that("verify error",{
			expect_error(check_epanet_error( as.integer(302)), "302")
})
test_that("verify warning",{
			expect_warning(check_epanet_error( as.integer(55)), "55")
})

context("quality codes")

test_that("numeric input",{
			
			x <- check_enum_code( 0, c("a","b") )
			expect_true( is.integer(x))
			
		})

test_that("character input",{
			
			x <- check_enum_code( "b", c("a","b") )
			expect_true( is.integer(x))
			expect_equal(x,1)
			
		})
