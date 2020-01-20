#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************


#####################################################
# Functions that retrieve other network information
#####################################################


#' ENgetcontrol
#'
#' Retrieve the parameters of a simple control statement.
#' 
#' @export
#' @useDynLib epanet2toolkit enGetControl
#' @param controlindex An integer specifying the control statement index.
#' 
#' @return list of parameters of the control statement: ctype, lindex, setting, nindex, level
#' 
#' @note Controls are indexed starting from 1 in the order in which they were entered into the
#'   \code{[CONTROLS]} section of the EPANET input file.
#'   
#' @seealso
#' \code{\link{ENsetcontrol}} 
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetcontrol(1)
#' ENclose() 
ENgetcontrol <- function(controlindex) {
  
  if (missing(controlindex)) {
    stop("Need to specify the control statement index(es).")
  }
  if (is.numeric(controlindex)) {
    controlindex = as.integer(controlindex)
  }
  else {
    stop("The control statement index must be an integer.")
  }
  if (length(controlindex) != 1 ) {
    stop("Can only accept one control ID at a time.")
  }
  
  ctrl <- .Call("enGetControl", controlindex)
  check_epanet_error(ctrl$errorcode)
  
  controllist <- list(ctype = ctrl$valueint[1], lindex = ctrl$valueint[2], 
                    setting = ctrl$valuefloat[1], nindex = ctrl$valueint[3], 
                    level = ctrl$valuefloat[2])
  
  return(controllist)
  
} 



#' Set the parameters of a simple control statement
#' 
#' \code{ENsetcontrol} sets the parameters of a simple control statements.
#' 
#' @export
#' @useDynLib epanet2toolkit enSetControl
#' @param cindex Integer, control statement index
#' @param ctype	Integer or character string, the control type code (see Details below).
#' @param lindex Integer, index of the link being controlled.
#' @param setting Numeric, value of the control setting.
#' @param nindex Integer, the index of the controlling node.
#' @param level value of controlling water level or pressure for level controls or of
#'   time of control action (in seconds) for time-based controls
#' 
#' @return Returns NULL invisibly on success or raises an error or warning. 
#' 
#' @details Controls are indexed starting from 1 in the order in which they were entered into the
#'   \code{[CONTROLS]} section of the EPANET input file.
#'   Control type codes consist of the following:
#' 
#'   \tabular{lll}{
#' 		\code{EN_LOWLEVEL}  \tab  0  \tab  Control applied when tank level or node pressure\cr
#'        					\tab  	 \tab    drops below specified level\cr
#' 		\code{EN_HILEVEL}   \tab  1  \tab  Control applied when tank level or node pressure\cr
#'							\tab	 \tab  rises above specified level\cr
#' 		\code{EN_TIMER}     \tab  2  \tab  Control applied at specific time into simulation\cr
#' 		\code{EN_TIMEOFDAY} \tab  3  \tab  Control applied at specific time of day
#'   }
#'   For pipes, a \code{setting} of 0 means the pipe is closed and 1 means it is open. For a
#'   pump, the \code{setting} contains the pump's speed, with 0 meaning the pump is closed and
#'	 1 meaning it is open at its normal speed. For a valve, the \code{setting} refers to the valve's
#'   pressure, flow, or loss coefficient, depending on valve type.
#' 
#'   For Timer or Time-of-Day controls set the \code{nindex} parameter to 0.
#' 
#'   For level controls, if the controlling node \code{nindex} is a tank then the level parameter
#'   should be a water level above the tank bottom (not an elevation). Otherwise \code{level}
#'   should be a junction pressure.
#' 
#'   To remove a control on a particular link, set the \code{lindex} parameter to 0. Values for the
#'   other parameters in the function will be ignored.
#'   
#' @seealso 
#' \code{ENsetcontrol}
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetcontrol(1)
#' ENsetcontrol(1, ctype=2, lindex=3, setting=1, nindex=0, level=54)		
#' ENgetcontrol(1)
#' ENclose() 
ENsetcontrol <- function(cindex, ctype = NULL, lindex = NULL, setting = NULL, nindex = NULL, level = NULL) {

  if (missing(cindex)) {
    stop("Need to specify the control index.")
  }	
  if (length(cindex) != 1) {
    stop("Can only set one control at a time.")
  }
  if (missing(ctype)) {
    stop("Need to specify the control statement type.")
  }
  if (missing(lindex)) {
    stop("Need to specify the index of the link being controlled.")
  }
  if (missing(setting)) {
    stop("Need to specify the value of the control setting.")
  }
  if (missing(nindex)) {
    stop("Need to specify the index of the controlling node.")
  }
  if (missing(level)) {
    stop("Need to specify the value of controlling water level or pressure for level controls or of	
           time of control action (in seconds) for time-based controls.")
  }
 

  codeTable <- c("EN_LOWLEVEL", "EN_HILEVEL", "EN_TIMER", "EN_TIMEOFDAY")
  ct <- check_enum_code( ctype, codeTable) 
 
  out <- .Call("enSetControl", cindex, ct, lindex, setting, nindex, level)
  check_epanet_error(out$errorcode)
  
  return(invisible())
  
} 
