#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************




context("get node index")
test_that("no crash calling on closed toolkit",{
  expect_error( x <- ENgetnodeindex("10") ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  nidx <- 	ENgetnodeindex("10")
  ENclose()
  expect_equal(nidx,1)
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(nidx <- ENgetnodeindex(c("10","15","20")))
  ENclose()
})
test_that("get error 203 on no index",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetnodeindex("11"),"203")
  ENclose()
})


context("get node ID")
test_that("no crash calling on closed toolkit",{
  expect_error( x <- ENgetnodeid(1) ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  nid <- 	ENgetnodeid(1)
  ENclose()
  expect_equal(nid,"10")
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(nid <- ENgetnodeid(c(1,2,3)))
  ENclose()
})
test_that("get error 203 on no ID",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetnodeid(550),"203")
  ENclose()
})


context("get node type")
test_that("no crash calling on closed toolkit",{
  expect_error( x <- ENgetnodetype(1) ) 
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  ntyp <- 	ENgetnodetype(1)
  ENclose()
  expect_equal(ntyp, 0)
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ntyp <- ENgetnodetype(c(1,2,3)))
  ENclose()
})
test_that("get error 203 on no index",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetnodetype(550),"203")
  ENclose()
})


context("get node value")
test_that("no crash calling on closed toolkit",{
  expect_error(x <- ENgetnodevalue(1,1) )
})
test_that("works for single input",{
  ENopen("Net3.inp","Net3.rpt")
  x <- 	ENgetnodevalue(5,0)
  ENclose()
  expect_equal(x, 131.9, tolerance=1e-5)
})
test_that("works for multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(x <-	ENgetnodevalue(5,0:3))
  ENclose()
})
test_that("get error 205 on no node",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetnodevalue(120,1),"203")
  ENclose()
})
test_that("get error 251 on wrong code",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENgetnodevalue(1,100))
  ENclose()
})


context("set node value")
test_that("no crash calling on closed toolkit",{
  expect_error( ENsetnodevalue(1,0,120) )
})
test_that("works on single input",{
  ENopen("Net3.inp","Net3.rpt")
  ENsetnodevalue(5,0,134.5)		
  x <- ENgetnodevalue(5,0)
  ENclose()
  expect_equal(x,134.5, tolerance = 1e-6)
})
test_that("error on multiple input",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error( ENsetnodevalue(0, 3:4, c(133.5,125.5))		)
  ENclose()
})
test_that("get error 205 on no pattern",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetnodevalue(120,0,131.4),"203")
  ENclose()
})
test_that("get error 251 on wrong parameter code",{
  ENopen("Net3.inp","Net3.rpt")
  expect_error(ENsetnodevalue(1,100,1.5),"251")
  ENclose()
})
test_that("returns NULL invisibly on success",{
  ENopen("Net3.inp","Net3.rpt")
  x <- withVisible(ENsetnodevalue(5,0,134.5))
  ENclose()
  expect_null(x$value)
  expect_false(x$visible)
})


context("ENadd/deletenode")
test_that("add delete node",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("node-tests-", suffix,".rpt")
  outFile <- paste0("node-tests-", suffix,".out")
  ENinit(rptFile, outFile, "EN_CFS", "EN_DW")
  idx1 <- ENaddnode('node1', 'EN_JUNCTION')
  idx2 <- ENaddnode('2a', 'EN_JUNCTION')
  expect_true( idx1 ==1 )
  expect_true( idx2 ==2 )

  ENdeletenode(idx1, "EN_UNCONDITIONAL")

  idx2a <- ENgetnodeindex('2a')
  expect_false(idx2 == idx2a )
  ENclose()

  # clean up
  file.remove(rptFile)
})

context("ENsetnodeid")
test_that("set node id",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("node-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile)
  oldid <- ENgetnodeid(5)
  ENsetnodeid(5, suffix)
  newid <- ENgetnodeid(5)
  expect_false(oldid == newid)
  expect_true(newid == suffix)
  ENclose()

  file.remove(rptFile)
})

context("ENsetjuncdata")
test_that("set junc data",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("node-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile)

  ENsetjuncdata(nodeindex=5, elevation=999, demand=123)

  elev = ENgetnodevalue(5,"EN_ELEVATION")
  expect_equal(as.integer(elev), 999)

  dmd = ENgetnodevalue(5,"EN_BASEDEMAND")
  expect_equal(as.integer(dmd), 123)
  ENclose()

  file.remove(rptFile)
})

context("ENsettankdata")
test_that("set tank data",{
  suffix <- paste0( sample(letters, 4), collapse="")
  rptFile <- paste0("node-tests-", suffix,".rpt")
  ENopen("Net1.inp", rptFile)
  #;ID              	Elevation   	InitLevel   	MinLevel    	MaxLevel    	Diameter    	MinVol      	VolCurve
  #  2               	850         	120         	100         	150         	50.5        	0           	                	;
  tid = ENgetnodeindex("2")

  ENsettankdata(nodeindex=tid,
                 elevation=888,
                 init_level = 125,
                 min_level = 99,
                 max_level = 145,
                 diameter = 44,
                 min_volume = 1)

  elev = ENgetnodevalue(tid,"EN_ELEVATION")
  expect_equal(as.integer(elev), 888)

  initlvl = ENgetnodevalue(tid,"EN_TANKLEVEL")
  expect_equal(as.integer(initlvl), 125)
  ENclose()

  file.remove(rptFile)
})
