#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************

context("solve Q")
test_that("works",{
			ENopen("Net3.inp","Net3.rpt","Net3.bin")
			ENsolveH()
			expect_silent( ENsolveQ()) 
			ENclose()
		})

test_that("no crash calling closed toolkit",{
			expect_error( ENsolveQ()) 
		})


context("open Q")
test_that("works",{
			ENopen("Net3.inp","Net3.rpt","Net3.bin")
			ENsolveH()
			expect_silent( ENopenQ()) 
			ENclose()
		})
test_that("no crash calling closed toolkit",{
			expect_error( ENopenQ()) 
		})
test_that("throws error ",{
			expect_error( ENopenQ(), "102") 
		})

context("init  Q")
test_that("works",{
			ENopen("Net3.inp","Net3.rpt","Net3.bin")
                        ENsolveH()
			ENopenQ() 
			expect_silent(ENinitQ(0))
			ENclose()
		})
test_that("no crash calling closed toolkit",{
			expect_error( ENinitQ(0)) 
		})
test_that("throws error ",{
			expect_error( ENinitQ(0), "105") 
		})



context("run  Q")
test_that("works",{
			ENopen("Net3.inp","Net3.rpt","Net3.bin")
			ENsolveH()
			ENopenQ() 
			ENinitQ(0)
			expect_silent( t <-  ENrunQ()) 
			ENclose()
		})
test_that("no crash calling closed toolkit",{
			expect_error( ENrunQ()) 
		})
test_that("throws error ",{
			expect_error( ENinitQ(0), "105") 
		})


context("next  Q")
test_that("works",{
			ENopen("Net3.inp","Net3.rpt","Net3.bin")
			ENsolveH()
			ENopenQ() 
			ENinitQ(0)
			ENrunQ() 
			expect_silent( t <- ENnextQ() )
			ENclose()
			expect_false( t == 0 )
		})
test_that("no crash calling closed toolkit",{
			expect_error( ENnextQ()) 
		})
test_that("throws error ",{
			expect_error( ENnextQ(), "105") 
		})

			
context("step  Q")
test_that("works",{
			ENopen("Net3.inp","Net3.rpt","Net3.bin")
			ENsolveH()
			ENopenQ() 
			ENinitQ(0)
			ENrunQ() 
			expect_silent( t <- ENstepQ() )
			ENclose()
			expect_true( t > 3600 )
		})
test_that("no crash calling closed toolkit",{
			expect_error( ENstepQ()) 
		})
test_that("throws error ",{
			expect_error( ENstepQ(), "105") 
		})




context("close  Q")
test_that("works",{
			ENopen("Net3.inp","Net3.rpt","Net3.bin")
			ENsolveH()
			ENopenQ() 
			expect_silent( ENcloseQ() )
			ENclose()
		})
test_that("no crash calling closed toolkit",{
			expect_error( ENcloseQ()) 
		})
test_that("throws error ",{
			expect_error( ENcloseQ(), "102") 
		})

context("get qual type")
test_that("works",{
			ENopen("Net3.inp","Net3.rpt","Net3.bin")
			qt <- ENgetqualtype()
			x <- ENgetnodeindex("Lake")
			ENclose()
			
			expect_true( is.list( qt))
			expect_equal(qt$tracenode, x)
		})
test_that("no crash calling closed toolkit",{
			expect_error( ENgetqualtypeQ()) 
		})
test_that("throws error ",{
			expect_error( ENgetqualtype(), "102") 
		})



context("set qual type")
test_that("works with integer",{
			
			ENopen("Net3.inp","Net3.rpt","Net3.bin") 
			ENsetqualtype(as.integer(0) )
			x <- ENgetqualtype()
			expect_equal(x[[1]], 0)
			ENclose()			
		})

test_that("works with numeric ",{
			
			ENopen("Net3.inp","Net3.rpt","Net3.bin") 
			ENsetqualtype(0 )
			x <- ENgetqualtype()
			expect_equal(x[[1]], 0)
			ENclose()			
		})

test_that("works with character",{
			
			ENopen("Net3.inp","Net3.rpt","Net3.bin") 
			ENsetqualtype("EN_NONE" )
			x <- ENgetqualtype()
			expect_equal(x[[1]], 0)
			ENclose()			
		})


test_that("set qual type",{
  expect_silent({
	ENopen("Net3.inp","Net3.rpt","Net3.bin") 
	qtype0 <- ENgetqualtype()
	setqtype1 <- ENsetqualtype(qualcode="EN_NONE")
	qtype1 <- ENgetqualtype()
	setqtype2 <- ENsetqualtype(qualcode="EN_TRACE", tracenode="River")
	qtype2 <- ENgetqualtype()
	ENclose()
	})
})



context("get qual info")
test_that("works",{
  ENopen("Net3.inp","Net3.rpt","Net3.bin") 
  x <- ENgetqualinfo()
  ENclose()
			
  expect_true( is.list(x))
  expect_equal( length(x), 4)
  expect_equal( x$qualcode,3 )
  expect_equal( x$tracenode, 94)
  expect_false( is.null(x$chemunit))
  expect_false( is.null(x$chemname))
})
test_that("no crash calling on closed toolkit",{
			expect_silent( x <- ENgetqualinfo() )
		})
