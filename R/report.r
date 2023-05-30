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
  if( !is.character(format) ) stop("format must be character")
  x <- .C("RENsetreport", format, as.integer(-1))
  check_epanet_error(x[[2]])
  return(invisible())
}


#' Sets the level of hydraulic status reporting.
#' 
#' @param level one of: EN_NO_REPORT, EN_NORMAL_REPORT, EN_FULL_REPORT
#' @useDynLib epanet2toolkit RENsetstatusreport
#' @export
ENsetstatusreport <- function(level){  
  if( !is.character(level) ) stop("level must be character")
	codeTable = c("EN_NO_REPORT", "EN_NORMAL_REPORT", "EN_FULL_REPORT")
  value <- lookup_enum_value(codeTable, level)
  x <- .C("RENsetstatusreport", as.integer(value), as.integer(-1))
  check_epanet_error(x[[2]])
  return(invisible())
}


#' Returns the text of an error message generated by an error code
#' 
#' @param errcode an error code.
#' @return error message 
#' @useDynLib epanet2toolkit RENgeterror
#' @export
ENgeterror <- function(errcode){
  buffer <- paste0(rep_len(" ",255), collapse='')  
  x <- .C("RENgeterror", as.integer(errcode), buffer, as.integer(nchar(buffer)), as.integer(-1))
  check_epanet_error(x[[4]])
  return(buffer)
}


#' Analysis convergence statistics.
#'
#' 
#' @param stat one of the statistics tabulated below
#' @returns value of the stat
#' @useDynLib epanet2toolkit RENgetstatistic
#' @export
#' @details  These statistics report the convergence criteria for the most current
#' hydraulic analysis and the cumulative water quality mass balance error at the
#' current simulation time. 
#' 
#' \tabular{ll}{
#'   \code{EN_ITERATIONS} \tab Number of hydraulic iterations taken. \cr
#'   \code{EN_RELATIVEERROR} \tab Sum of link flow changes / sum of link flows. \cr
#'   \code{EN_MAXHEADERROR} \tab Largest head loss error for links. \cr
#'   \code{EN_MAXFLOWCHANGE} \tab Largest flow change in links. \cr
#'   \code{EN_MASSBALANCE} \tab Cumulative water quality mass balance ratio. \cr
#'   \code{EN_DEFICIENTNODES} \tab Number of pressure deficient nodes. \cr
#'   \code{EN_DEMANDREDUCTION} \tab % demand reduction at pressure deficient nodes \cr
#' }
ENgetstatistic <- function(stat){
  
  codeTable <- c("EN_ITERATIONS", "EN_RELATIVEERROR", "EN_MAXHEADERROR", "EN_MAXFLOWCHANGE",
                 "EN_MASSBALANCE", "EN_DEFICIENTNODES","EN_DEMANDREDUCTION")
  statCode <- lookup_enum_value(codeTable, stat)
  x <- .C("RENgetstatistic", as.integer(statCode), -999999.0, as.integer(-1))
  check_epanet_error(x[[3]])
  val <- x[[2]]
  return(val)
}


#' Retrieves the order in which a node or link appears in an output file.
#' 
#' @param type a type of element (either EN_NODE or EN_LINK).
#' @param index the element's current index (starting from 1).
#' @returns the order in which the element's results were written to file.
#' @details If the element does not appear in the file then its result index is 0.
#'
#'  This function can be used to correctly retrieve results from an EPANET binary output file
#'  after the order of nodes or links in a network's database has been changed due to editing
#'  operations.
ENgetresultindex <-function(type, index){
  codeTable <- c("EN_NODE","EN_LINK")
  codeVal <- lookup_enum_value(codeTable, type)
  x <- .C("RENgetresultindex", as.integer(codeVal), as.integer(index), as.integer(-1), as.integer(-1))
  check_epanet_error(x[[4]])
  val <- x[[3]]
  return(val)
}