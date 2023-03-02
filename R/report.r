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

#' Clears the contents of a project's report file.
#' 
#' @export
#' @return Returns NULL invisibly; called for side effect
#' @useDynLib epanet2toolkit RENclearreport
ENclearreport <- function(){
  x <- .C("RENclearreport", as.integer(-1))
  check_epanet_error(x[[1]])
  return(invisible())
}

#' Resets a project's report options to their default values.
#' 
#' @export
#' @return Returns NULL invisibly; called for side effect
#' @useDynLib epanet2toolkit RENresetreport
#' 
#' @details After calling this function the default reporting options are in effect. These are:
#'  * no status report
#'  * no energy report
#'  * no nodes reported on
#'  * no links reported on
#'  * node variables reported to 2 decimal places
#'  * link variables reported to 2 decimal places (3 for friction factor)
#'  * node variables reported are elevation, head, pressure, and quality
#'  * link variables reported are flow, velocity, and head loss.
#' @md
ENresetreport <- function(){
  x <- .C("RENresetreport", as.integer(-1))
  check_epanet_error(x[[1]])
  return(invisible())
}

#' Processes a reporting format command.
#' 
#' @param format report formatting command:  one line from the [REPORT] section of an inp file
#' @useDynLib epanet2toolkit RENsetreport
#' @export
ENsetreport <- function(format){  
  if( !is.character(format) ) stop("rptFile must be character")
  x <- .C("RENsetreport", format, as.integer(-1))
  check_epanet_error(x[[2]])
  return(invisible())
}