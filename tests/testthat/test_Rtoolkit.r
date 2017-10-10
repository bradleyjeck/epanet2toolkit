#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************



context("node information")
test_that("node info",{
expect_silent({
ENopen("Net3.inp","Net3.rpt")
# get information about nodes (IDs, indexes, ...) 
nNodes <- ENgetcount("EN_NODECOUNT") 
#nids <- ENgetnodeid(seq(1 : nNodes))
#nind <- ENgetnodeindex(nids)
#ntyp <- ENgetnodetype(nind)
#nval <- ENgetnodevalue(nind, "EN_ELEVATION")
#nval2 <- ENgetnodevalue(seq(1, nNodes, by=2), c("EN_ELEVATION", "EN_BASEDEMAND"))

ENclose() 
})
})

context("link information")
test_that("link info",{
expect_silent({
ENopen("Net3.inp","Net3.rpt")
# get information about links 
nLinks <- ENgetcount("EN_LINKCOUNT")
#lids <- ENgetlinkid(seq(1 : nLinks))
#lind <- ENgetlinkindex(lids)
#ltyp <- ENgetlinktype(seq(1 : nLinks))
#lnodes <- ENgetlinknodes(lind)
#lval <- ENgetlinkvalue(lind, c("EN_DIAMETER", "EN_LENGTH", "EN_ROUGHNESS"))

ENclose() 
})
})



context("other network info ")
test_that("net info",{
expect_silent({
ENopen("Net3.inp","Net3.rpt")
# get other network information
#ctrl <- ENgetcontrol(c(1,3))
funits <- ENgetflowunits()
timeparam <- ENgettimeparam(c(0, 1, 2))
timeparam2 <- ENgettimeparam(c("EN_REPORTSTART", "EN_REPORTSTEP"))
units <- ENgetflowunits()
qtype <- ENgetqualtype()
ver <- ENgetversion()

ENclose()
})
})

#########################################
# set new values for network parameters
#########################################

context("setting controls")
test_that("set controls",{
expect_silent({
ENopen("Net3.inp","Net3.rpt")
# enSetControl ##################
#ctrl1 <- ENgetcontrol(c(1, 3))  	# get controls 1 and 3
#ctrl1$level = c(3601, 17)       	# change control settings
#setctrl1 <- ENsetcontrol(ctrl1) 	# set new control settings
#checkctrl1 <- ENgetcontrol(c(1, 3)) # check new settings

#setctrl2 <- ENsetcontrol(c(1, 3), c("EN_TIMER", "EN_LOWLEVEL"), c(118, 119), c(1, 1), c(0, 95), c(3602, 18))
#checkctrl2 <- ENgetcontrol(c(1, 3))

numctrls <- ENgetcount("EN_CONTROLCOUNT");
#ctrls <- ENgetcontrol(seq(1 : numctrls))
# selctrl <- subset(ctrls, (ctype == 0 & lindex == ENgetlinkindex("335")))
# newctrl <- selctrl
# newctrl$level = 17.5
# setctrl3 <- ENsetcontrol(newctrl)
# checkctrl3 <- ENgetcontrol(seq(1 : numctrls))

ENclose() 
})
})


context("setting node values ")
test_that("set node vals",{
expect_silent({
ENopen("Net3.inp","Net3.rpt") 
# enSetNodeValue
somenodes <- c(1, 3, 5)
newval <- data.frame(index = somenodes, paramcode = rep(0, 3), value = c(150, 130, 132))
#setnodeval1 <- ENsetnodevalue(newval)
#nodeval1 <- ENgetnodevalue(somenodes, "EN_ELEVATION") 
#setnodeval2 <- ENsetnodevalue(index = somenodes, paramcode = c(0, 1, 0), value = c(151, 1, 132.5))
#nodeval2 <- ENgetnodevalue(somenodes, c(0, 1))

ENclose()
})
})

context("setting link values ")
test_that("set link vals",{
expect_silent({
ENopen("Net3.inp","Net3.rpt")
# enSetLinkValue
somelinks <- c(5, 8, 15)
newlinkval <- data.frame(index = somelinks, paramcode = rep(0, 3), value = c(24, 18, 18))
#setlinkval1 <- ENsetlinkvalue(newlinkval)
#linkval1 <- ENgetlinkvalue(somelinks, "EN_DIAMETER")
#setlinkval2 <- ENsetlinkvalue(index = somelinks, paramcode = c(0, 2, 0), value = c(24, 115, 18))
#linkval2 <- ENgetlinkvalue(somelinks, c(0, 2))

ENclose()
})
})

