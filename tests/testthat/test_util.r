#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Bradley J Eck
#
#  
#****************************************/




context("long stored as char to int or char")

test_that("can return int",{
			
			x <- charlong_to_int_or_char( "123")
			expect_equal(x,123)
			
		})

test_that("can return char",{
			
			x <- charlong_to_int_or_char( "12345678901")
			expect_equal(x,"12345678901")
			
		})

context("enum lookup")
test_that("lookup works",{

  option_enums <- c("EN_TRIALS", "EN_ACCURACY", "EN_TOLERANCE", "EN_EMITEXPON", "EN_DEMANDMULT")
  intval <- lookup_enum_value(option_enums, "EN_ACCURACY")
  expect_equal(intval,1)
})

