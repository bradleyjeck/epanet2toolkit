#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#****************************************/

#' Write simulation report to the report file
#'
#' @export
#' @return Returns NULL invisibly; called for side effect
#' @useDynLib epanet2toolkit RENreport
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt", "Net1.bin")
#' ENsolveH()
#' ENsolveQ()
#' ENreport()
#' ENclose()
#' # clean up the created files 
#' file.remove("Net1.rpt") 
#' file.remove("Net1.bin") 
ENreport <- function(){

    x <- .C("RENreport", as.integer(-1))
    check_epanet_error(x[[1]])
    return( invisible() ) 
}

#' Copies the current contents of a project's report file to another file
#' 
#' @param rptFile destination file
#' 
#' @details This function allows toolkit clients to retrieve the contents of a project's
#' report file while the project is still open.
#' @export
#' @return Returns NULL invisibly; called for side effect
#' @useDynLib epanet2toolkit RENcopyreport
#' @return Returns NULL invisibly; called for side effect
ENcopyreport <- function(rptFile){

  if( !is.character(rptFile) ) stop("rptFile must be character")   
  x <- .C("RENcopyreport", rptFile, as.integer(-1))
  check_epanet_error(x[[2]])
  return(invisible())
}