#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Bradley J Eck and Ernesto Arandia
#
#*****************************************/

##  hydraulics functions of epanet toolkit 



#' ENsolveH
#' 
#' Solves the network hydraulics for all time periods
#' 
#' @return Returns NULL invisibly; called for side effect
#' @export
#' @useDynLib epanet2toolkit RENsolveH
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt","Net1.bin")
#' ENsolveH()
#' ENsolveQ()
#' ENgetnodevalue(2, "EN_PRESSURE")
#' ENclose() 
#' # clean-up the created files
#' file.remove("Net1.rpt") 
#' file.remove("Net1.bin") 
 ENsolveH <- function(){
    arg <- .C("RENsolveH", as.integer(-1) )
    err <- arg[[1]]
    check_epanet_error( err )
	return( invisible() )
 }
 
 
#' ENsaveH
#'  
#' Saves hydraulic results to binary file
#'
#' @return Returns NULL invisibly; called for side effect
#' @export
#' @useDynLib epanet2toolkit RENsaveH
#' @details   Must be called before ENreport() if no WQ simulation has been made.
#' Should not be called if ENsolveQ() will be used.
ENsaveH <- function(){
    arg <- .C("RENsaveH", as.integer(-1))
    err <- arg[[1]]
    check_epanet_error( err )
	return( invisible() )
}
 

#' Open hydraulics analysis system.
#' 
#' \code{ENopenH} opens the EPANET hydraulics analysis system.
#' 
#' @export
#' @useDynLib epanet2toolkit enOpenH
#' 
#' @details Call \code{ENopenH} prior to running the first hydraulic analysis using the 
#'   \code{ENinitH-ENrunH-ENnextH} sequence. Multiple analyses can be made before calling 
#'   \code{ENcloseH} to close the hydraulic analysis system.
#'   
#'   Do not call this function if \code{ENsolveH} is being used to run a complete hydraulic analysis.
#' 
#' @seealso \code{ENinitH}, \code{ENrunH}, \code{ENnextH}, \code{ENcloseH}
#' @return Returns NULL invisibly; called for side effect
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENopenH()
#' ENinitH(0)
#' ENrunH()
#' ENcloseH()
#' ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
ENopenH <- function() {
	
#  if( getOpenHflag()){
#    warning("Epanet hydraulic solver was already open")
#  } 
#  else { 
    result <- .Call("enOpenH")					
    check_epanet_error(result$errorcode)
#  }
  
  return( invisible() )
  
} 

 
#' Initialize hydraulic engine 
#' 
#' \code{ENinitH} Initializes storage tank levels, link status and settings, and the simulation clock 
#'   time prior to running a hydraulic analysis.
#' 
#' @export
#' @useDynLib epanet2toolkit enInitH
#' 
#' @param flag A two-digit flag indicating if hydraulic results will be saved to the
#'   hydraulics file (rightmost digit) and if link flows should be re-initialized.
#' 
#' @details Call \code{ENinitH} prior to running a hydraulic analysis using \code{ENrunH} and
#'   \code{ENnextH}.\code{ENopenH} must have been called prior to calling \code{ENinitH}. Do not call 
#'   \code{ENinitH} if a complete hydraulic analysis is being made with a call to \code{ENsolveH}.
#'   Values of flag have the following meanings:
#'   
#'   \tabular{ll}{
#'    00   \tab  do not re-initialize flows, do not save results to file\cr
#'    01   \tab  do not re-initialize flows, save results to file\cr
#'    10   \tab  re-initialize flows, do not save results to file\cr
#'    11   \tab  re-initialize flows, save results to file
#'    } 
#'   
#'    Set \code{flag} to 1 (or 11) if you will be making a subsequent water quality run, using 
#'    \code{ENreport} to generate a report, or using \code{ENsavehydfile} to save the binary 
#'    hydraulics file. 
#' 
#' @seealso \code{ENopenH}, \code{ENrunH}, \code{ENnextH}, \code{ENcloseH}
#' @return Returns NULL invisibly; called for side effect
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENopenH()
#' ENinitH(0)
#' ENrunH()
#' ENcloseH()
#' ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
ENinitH <- function(flag) {
	
	# check the arguments
	if (missing(flag)) {
		stop("Need to specify the initialization flag.")
	}
	if (is.numeric(flag)) {
		flag = as.integer(flag)
	}
	else {
		stop("The initialization flag must be an integer.")
	}	
  
  result <- .Call("enInitH", flag)					
  check_epanet_error(result$errorcode)
  
  return(invisible())
	
} 

#' run hydraulics engine
#' 
#' \code{ENrunH} Runs a single period hydraulic analysis, retrieving the 
#' current simulation clock time \code{t}.
#' 
#' @export
#' @useDynLib epanet2toolkit enRunH
#' 
#' @details Use \code{ENrunH} along with \code{ENnextH} in a while loop to 
#'   analyze hydraulics in each period of an extended period simulation. 
#'   This process automatically updates the simulation clock time so treat 
#'   \code{t} as a read-only variable.
#'   
#'   \code{ENinitH} must have been called prior to running the 
#'   \code{ENrunH-ENnextH} loop.
#'   
#'   See \code{ENnextH} for an example of using this function.
#'   
#' @seealso \code{ENopenH}, \code{ENinitH}, \code{ENnextH}, \code{ENcloseH}
#' @return Returns NULL invisibly; called for side effect
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENopenH()
#' ENinitH(0)
#' ENrunH()
#' ENcloseH()
#' ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
ENrunH <- function() {
	
  result <- .Call("enRunH")					
  check_epanet_error(result$errorcode)
  
  return(result$value)
  
} 

#' determine the next hydraulic step
#' 
#' \code{ENnextH} determines the length of time until the next 
#' hydraulic event occurs in an extended period simulation.
#' 
#' @export
#' @useDynLib epanet2toolkit enNextH
#' 
#' @return An integer, the time (in seconds) until next hydraulic event 
#'   occurs or 0 if at the end of the simulation period.
#' 
#' @details This function is used in conjunction with \code{ENrunH} to 
#'   perform an extended period hydraulic analysis (see example below).
#'   
#'   The return value is automatically computed as the smaller of:
#'   
#'   \itemize{
#'   \item the time interval until the next hydraulic time step begins
#'   \item the time interval until the next reporting time step begins
#'   \item the time interval until the next change in demands occurs
#'   \item the time interval until a tank becomes full or empty
#'   \item the time interval until a control or rule fires
#'   }
#'   
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#'   # store simulation times
#'   t = NULL
#'   ENopenH()
#'   ENinitH(11)
#'   repeat {
#'     t <- c(t, ENrunH())
#'     tstep <- ENnextH()
#'     if (tstep == 0) {
#'       break
#'     }
#'   }
#'   ENcloseH()
#'   ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
#'   
#' @seealso \code{ENopenH}, \code{ENinitH}, \code{ENrunH}, \code{ENcloseH}, \code{ENsettimeparam}
#' 
ENnextH <- function() {
	
  result <- .Call("enNextH")					
  check_epanet_error(result$errorcode)
  
  return(result$value)
  
}

#' close hydraulics engine
#' 
#' \code{ENcloseH} closes the hydraulic analysis system, freeing all 
#'   allocated memory
#'
#' @return Returns NULL invisibly; called for side effect
#' 
#' @export
#' @useDynLib epanet2toolkit enCloseH
#' 
#' @details Call \code{ENcloseH} after all hydraulics analyses have been made using 
#'   \code{ENinitH-ENrunH-ENnextH}. Do not call this function if \code{ENsolveH} is being used.
#'   
#' @seealso \code{ENopenH}, \code{ENinitH}, \code{ENrunH}, \code{ENnextH}
#' 
ENcloseH <- function() {
  
#    if( !getOpenHflag()){
#      warning("Epanet hydraulics already closed")
#    } 
#    else { 
      result <- .Call("enCloseH")					
      check_epanet_error(result$errorcode)
#    }
    return( invisible() )
} 
