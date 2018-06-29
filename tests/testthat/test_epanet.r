#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Bradley J Eck and Ernesto Arandia
#
#*****************************************/


context("ENepanet")
test_that("ENepanet all args",{
  expect_silent( ENepanet("Net1.inp", "Net1.rpt", "Net1.bin") ) 
})

test_that("RENepanet null bin",{

  expect_silent( ENepanet("Net1.inp", "Net1.rpt") ) 
})

test_that("retuns null invisibly",{
	 wv <- withVisible( ENepanet("Net1.inp", "Net1.rpt") ) 
	 expect_null(wv$value)
	 expect_false(wv$visible)
 }) 

test_that("R func ENepanet bad input",{

    expect_error( ENepanet(NA, NA, NA) , "inp") 
    expect_error( ENepanet("Net1.inp", NA, NA) , "rpt") 
    expect_error( ENepanet("Net1.inp", "Net1.rpt", NA) , "bin") 

})

test_that("returns error code",{
			expect_error( ENepanet("Net55.inp", "Net55.rpt"), "302")
		})



context("save inp file")
test_that("func loads",{
  expect_true( is.loaded("RENsaveinpfile"))
})

test_that("func works",{
 ENopen("Net1.inp", "Net1.rpt","")
 ENsaveinpfile("new.inp")
 expect_true( file.exists("new.inp"))
 ENclose()
 # clean-up
 file.remove("new.inp")		
})


context("get count")

test_that("no crash calling on closed toolkit",{
  expect_false( getOpenflag() )
  expect_error( x <- ENgetcount(0) ) 
})
test_that("works with character input",{
			ENopen("Net3.inp","Net3.rpt")  
			
			nNodes <- ENgetcount("EN_NODECOUNT") 
			nLinks <- ENgetcount("EN_LINKCOUNT")
			expect_equal(nNodes, 97 )	
			expect_equal(nLinks, 119 )	
			ENclose()			
		})

test_that("works with numeric input",{
			
			ENopen("Net3.inp","Net3.rpt")  
			nPatt <- ENgetcount(3)
			nCont <- ENgetcount(5)
			expect_equal(nPatt, 5 )	
			expect_equal(nCont, 6 )	
			
			nNodes <- ENgetcount(0 ) 
			nLinks <- ENgetcount(2)
			expect_equal(nNodes, 97 )	
			expect_equal(nLinks, 119 )	
			
			ENclose()			
			
		})

test_that("returns error code",{
			
			ENopen("Net3.inp","Net3.rpt")  
			expect_error( ENgetcount(555),"251")
			ENclose() 
			
		})

test_that("error on multiple input",{
			ENopen("Net3.inp","Net3.rpt")  
			expect_error( ENgetcount(c(0,1,2)))
			ENclose() 
		})


context("get version")
test_that("works",{
			
			v <- ENgetversion()
			expect_equal(v, as.integer(20100))
			
		})

