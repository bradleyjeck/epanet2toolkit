#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************




context("using .Call ")

test_that("call the funcs",{
			
expect_silent({

# open the inp file
out <- .Call("enOpen", c("Net3.inp","net3.rpt"," "))

# get functions for nodes
ind1 <- .Call("enGetNodeIndex", "10")
ind2 <- .Call("enGetNodeIndex", "15")
ind3 <- .Call("enGetNodeIndex", "20")
id1 <- .Call("enGetNodeID", 1)
type1 <- .Call("enGetNodeType", ind3)
type2 <- .Call("enGetNodeType", ind2)
elev1 <- .Call("enGetNodeValue", ind3, 0)

# get functions for links
indlink <- .Call("enGetLinkIndex", "20")
idlink <- .Call("enGetLinkID", 5)
typelink <- .Call("enGetLinkType", indlink)
diamlink <- .Call("enGetLinkValue", indlink, 0)
nodeslink <- .Call("enGetLinkNodes", indlink)

# get functions for patterns
idpatt <- .Call("enGetPatternID", 3)
indexpatt <- .Call("enGetPatternIndex", "2")
lenpatt <- .Call("enGetPatternLen", 5)
valpatt <- .Call("enGetPatternValue", 3, 12)

# get control
ctrl1 <-.Call("enGetControl", 1)
ctrl2 <-.Call("enGetControl", 2)
ctrl3 <-.Call("enGetControl", 3)
ctrl4 <-.Call("enGetControl", 4)
ctrl5 <-.Call("enGetControl", 5)

# get flow units
units <- .Call("enGetFlowUnits")

# time parameter
timepar <- .Call("enGetTimeParam", 0)

# quality type
qtype <- .Call("enGetQualType")

# get option

# version
ver <- .Call("enGetVersion")

# set control
setctrl <- .Call("enSetControl", 3, 0, 119, 1, 95, 17)

nodevalout <- .Call("enSetNodeValue", 1, 0, 156)

linkvalout <- .Call("enSetLinkValue", 3, 2, 189)

setpatt <- .Call("enSetPattern", 3, as.numeric(rep(621,24)),24)
valpatt <- .Call("enGetPatternValue", 3, 12)

# close the toolkit
out <- .Call("enClose")
})

})