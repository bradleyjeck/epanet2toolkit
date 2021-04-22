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
 
