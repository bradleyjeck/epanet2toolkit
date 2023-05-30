#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************


#' ENepanet
#' 
#' runs a complete EPANET simulation
#'
#' @export
#' @param inpFile name of input file
#' @param rptFile name of report file (to be created)
#' @param binOutFile name of optional binary output file 
#' @return Returns NULL invisibly; called for side effect
#' @useDynLib epanet2toolkit RENepanet
#' @examples 
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp") 
#' print(inp)
#' ENepanet( inp, "Net1.rpt") 
#' # try opening Net1.rpt in a text editor or reading it back
#' # into R with the read.rpt() function in package epanetReader
#' myRpt <- epanetReader::read.rpt("Net1.rpt")
#' summary(myRpt)
#' # clean-up the created file 
#' file.remove("Net1.rpt")
ENepanet <- function( inpFile, rptFile, binOutFile=""){
   # arg checking
   if( !is.character(inpFile) ) stop("inpFile must be character")   
#   if( !file.exists(inpFile)) stop(paste(inpFile, "does not exist"))
   if( !is.character(rptFile) ) stop("rptFile must be character")   
   if( !is.character(binOutFile) ) stop("binOutFile must be character")

   arg <- .C("RENepanet", inpFile, rptFile, binOutFile, as.integer(-1) )
   
   err <- arg[[4]]
   check_epanet_error( err )
   invisible()
}

#' ENinit
#' 
#' Initializes an empty EPANET network
#' 
#' @param rptFile	the name of a report file to be created (or "" if not needed).
#' @param outFile	the name of a binary output file to be created (or "" if not needed).
#' @param unitsType	the choice of flow units. One of: "EN_CFS", "EN_GPM", "EN_MGD",
#'  "EN_IMGD", "EN_AFD", "EN_LPS", "EN_LPM", "EN_MLD", "EN_CMH", "EN_CMD"
#' @param headLossType	the choice of head loss formula . One of: EN_HW, EN_DW, EN_CM
#' @return Returns NULL invisibly; called for side effect
#' @useDynLib epanet2toolkit RENinit
#' @details This function should be called to create an empty EPANET project without 
#' an EPANET-formatted input file.  If the
#' project receives it's network data from an input file then there is no need to
#' call this function; use ENopen instead.
ENinit <- function( rptFile, outFile, unitsType, headLossType){

   FlowUnitsEnums <-c("EN_CFS" ,"EN_GPM" 	,"EN_MGD" 	,"EN_IMGD" 	,"EN_AFD" ,"EN_LPS" ,"EN_LPM" ,"EN_MLD" ,"EN_CMH" ,"EN_CMD")
   flowUnitsVal <- lookup_enum_value(FlowUnitsEnums, unitsType)

   HeadLossEnums <- c("EN_HW","EN_DW","EN_CM")
   headlossVal <- lookup_enum_value(HeadLossEnums, headLossType)

   arg <- .C("RENinit", rptFile, outFile, flowUnitsVal, headlossVal, as.integer(-1))
   err <- arg[[5]]
   check_epanet_error(err)
   return(invisible())
}


#' ENaveinpfile
#'   
#' Saves current data to "INP" formatted text file.
#' 
#' @return Returns NULL invisibly; called for side effect
#' @param filename The file path to create
#' @export
#' @useDynLib epanet2toolkit RENsaveinpfile
 ENsaveinpfile <- function(filename){
    arg <- .C("RENsaveinpfile", filename, as.integer(-1) )
    err <- arg[[2]]
    check_epanet_error( err )
 }
 
 
 

#' Retrieve the current version number of the EPANET Toolkit.
#' 
#' \code{ENgetversion} retrieves the current version number of the EPANET Toolkit.
#' 
#' @export
#' @useDynLib epanet2toolkit RENgetversion
#' @return An integer, the Toolkit version number.
#' 
#' @note The version number is a 5-digit integer that increases sequentially from
#'   20001 with each new update of the Toolkit.
#' @examples
#' ENgetversion()
ENgetversion <- function() {
	
	x <- .C("RENgetversion", as.integer(0), as.integer(-1))
	check_epanet_error(x[[2]])
	return(x[[1]])
	
} 
 
