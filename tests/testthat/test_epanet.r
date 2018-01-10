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

test_that("no leaky file descriptors",{

get_os <- function(){
sysinf <- Sys.info()
if (!is.null(sysinf)){
os <- sysinf['sysname']
if (os == 'Darwin')
os <- "osx"
} else { ## mystery machine
os <- .Platform$OS.type
if (grepl("^darwin", R.version$os))
os <- "osx"
if (grepl("linux-gnu", R.version$os))
os <- "linux"
}
tolower(os)
}

get_num_open_files <- function() {
os <- get_os()
if (os == "linux") {
# using the current R process PID, we check the number of entries on /proc//fd folder
# each entry represents an open file descriptor
# note that those entries and the parent folder belongs to R process user (no root required)
return (length(dir(paste("/proc/", Sys.getpid() , "/fd/", sep=""))))
} else if (os == "osx") {
# we use lsof and wc commands to count the number of active file descriptors of R process
return (system(command=paste("lsof -a -d 1-999 -p ", Sys.getpid(), " | wc -l", sep=""), intern = TRUE))
} else {
# dont know how to get open file descriptors on Windows or other arch; any constant value here will pass the test
return (0)
}
}

numOpenFilesBefore <- get_num_open_files()
ENepanet("Net3.inp", "Net3_xxxx.rpt")
numOpenFilesAfter <- get_num_open_files()
file.remove("Net3_xxxx.rpt")

expect_equal(numOpenFilesAfter, numOpenFilesBefore)


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

context("get flow units -- move to test_options")
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

