#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************





context("get pattern id")
test_that("no crash calling on closed toolkit",{
			expect_error( x <- ENgetpatternid(1) ) 
		})
test_that("works for single input",{
		ENopen("Net3.inp","Net3.rpt")
		pid <- 	ENgetpatternid(1)
		ENclose()
		expect_equal(pid,"1")
		})
test_that("works for multiple input",{
		ENopen("Net3.inp","Net3.rpt")
    expect_error(pid <-	ENgetpatternid(1:3))
		ENclose()
		})
test_that("get error 205 on no pattern",{
    ENopen("Net3.inp","Net3.rpt")
    expect_error(ENgetpatternid(12),"205")
    ENclose()
    })

context("get pattern index")
test_that("no crash calling on closed toolkit",{
			expect_error( x <- ENgetpatternindex("1") ) 
		})
test_that("works for single input",{
		ENopen("Net3.inp","Net3.rpt")
		pidx <- 	ENgetpatternindex("1")
		ENclose()
		expect_equal(pidx,1)
		})
test_that("works for multiple input",{
		ENopen("Net3.inp","Net3.rpt")
		expect_error(pidx <- ENgetpatternindex(c("1","2","3")))
		ENclose()
		})
test_that("get error 205 on no pattern",{
    ENopen("Net3.inp","Net3.rpt")
    expect_error(ENgetpatternindex("12"),"205")
    ENclose()
    })

context("get pattern length")
test_that("no crash calling on closed toolkit",{
			expect_error( x <- ENgetpatternlen(1) ) 
		})
test_that("works for single input",{
		ENopen("Net3.inp","Net3.rpt")
		x <- 	ENgetpatternlen(1)
		ENclose()
		expect_equal(x,24)
		})

test_that("works for multiple input",{
		ENopen("Net3.inp","Net3.rpt")
		expect_error(x <- ENgetpatternlen(1:4))
		ENclose()
		})
test_that("get error 205 on no pattern",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetpatternlen(12),"205")
  ENclose()
})

context("get pattern value")
test_that("no crash calling on closed toolkit",{
			expect_error(x <- ENgetpatternvalue(1,1) )
		})
test_that("works for single input",{
		ENopen("Net3.inp","Net3.rpt")
		x <- 	ENgetpatternvalue(5,5)
		ENclose()
		expect_equal(x,4531)
		})
test_that("works for multiple input",{
		ENopen("Net3.inp","Net3.rpt")
		expect_error(x <-	ENgetpatternvalue(5,5:7))
		ENclose()
		})
test_that("get error 205 on no pattern",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetpatternvalue(12,1),"205")
  ENclose()
})
test_that("get error 251 on wrong period",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetpatternvalue(1,100),"251")
  ENclose()
})


context("set pattern")
test_that("no crash calling on closed toolkit",{
			expect_error( ENsetpattern(1,1) )
		})
test_that("works on simple input",{
		ENopen("Net3.inp","Net3.rpt")
	  ENsetpattern(1, 1:10)		
		x <- ENgetpatternvalue(1,10)
		ENclose()
		expect_equal(x,10)
		})
test_that("error on multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error( ENsetpattern(2, 3:4, 1:10) )
  ENclose()
})
test_that("get error 205 on no pattern",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetpattern(12,1:10),"205")
  ENclose()
})

test_that("returns NULL invisibly on success",{
			ENopen("Net1.inp", "Net1.rpt")
			x <- withVisible( ENsetpattern(1, 1:10) )
			ENclose()	
			expect_null( x$value )
			expect_false( x$visible )
		})



context("set pattern value")
test_that("no crash calling on closed toolkit",{
  expect_error( ENsetpatternvalue(1,1, 1.5) )
})

test_that("works on single input",{
  ENopen("Net3.inp","Net3.rpt")
  ENsetpatternvalue(2, 3, 1.33)		
  x <- ENgetpatternvalue(2,3)
  ENclose()
  
  expect_equal(x,1.33, tolerance = 1e-6)
})

test_that("error on multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error( ENsetpatternvalue(2, 3:4, c(1.33,1.50))		)
  ENclose()
})
test_that("get error 205 on no pattern",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetpatternvalue(12,1,1.5),"205")
  ENclose()
})
test_that("get error 251 on wrong period",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetpatternvalue(1,100,1.5),"251")
  ENclose()
})

test_that("returns NULL invisibly on success",{
  ENopen("Net3.inp","Net3.rpt")
  x <- withVisible( ENsetpatternvalue(2, 3, 1.33)		)
			ENclose()	
			expect_null( x$value )
			expect_false( x$visible )
		})
