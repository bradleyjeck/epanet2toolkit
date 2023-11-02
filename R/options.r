#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************


#' Retrieve the value of an analysis option.
#' 
#' \code{ENgetoption} retrieves the value of one or more particular analysis options.
#' 
#' @export
#' @useDynLib epanet2toolkit RENgetoption
#' @param optioncode A character or integer specifying the option code 
#'   (see below).
#' 
#' @return numeric value of the specified analysis option(s).
#' 
#' @details Option codes consist of the following constants:
#'   \tabular{ll}{
#'   \code{EN_TRIALS}     \tab   0  \cr
#'   \code{EN_ACCURACY}   \tab   1  \cr
#'   \code{EN_TOLERANCE}  \tab   2  \cr
#'   \code{EN_EMITEXPON}  \tab   3  \cr
#'   \code{EN_DEMANDMULT} \tab   4  
#'   }
#' 
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetoption(0)
#' ENgetoption("EN_TRIALS")
#' ENclose()
ENgetoption <- function(optioncode) {
	
	codeTable = c("EN_TRIALS", "EN_ACCURACY", "EN_TOLERANCE", "EN_EMITEXPON", "EN_DEMANDMULT")

	# check the arguments
	if( length(optioncode) != 1 ) stop("can only get one option at time")
	if (missing(optioncode)) {
		stop("Need to specify the analysis option code.")
	}
	if (is.character(optioncode)) {		
		code <- as.integer(match(optioncode, codeTable) - 1)		
	}
	else if (is.numeric(optioncode)) {
		code = as.integer(optioncode)
	}
	else if (is.integer(optioncode)) {
	    code <- optioncode	
	}
	else{
		stop("The analysis option code must be a character string or an integer.")
	}	
	if (any(is.na(code))) {
		stop("The analysis option code specified is incorrect.")
	}
	
	x <- .C("RENgetoption", code, 0.0, as.integer(-1))
	check_epanet_error( x[[3]])
	return( x[[2]])
}


#' Set the value of a particular analysis option.
#' 
#' \code{ENsetoption} sets the value of a particular analysis option.
#' 
#' @export
#' @useDynLib epanet2toolkit RENsetoption
#' @param optioncode An integer or character vector specifying  the option
#' @param value numeric 
#' 
#' @details Option codes consist of the following constants:
#'
#'   \tabular{lr}{
#' 	 \code{EN_TRIALS}		\tab	0\cr
#' 	 \code{EN_ACCURACY}  	\tab	1\cr
#' 	 \code{EN_TOLERANCE}	\tab	2\cr
#'   \code{EN_EMITEXPON}	\tab	3\cr
#'   \code{EN_DEMANDMULT}	\tab	4	
#' 	 }   
#' 
#' 
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetoption("EN_TRIALS")
#' ENsetoption("EN_TRIALS", 22)
#' ENgetoption("EN_TRIALS")
#' ENclose()
ENsetoption <- function(optioncode, value) {

	codeTable = c("EN_TRIALS", "EN_ACCURACY", "EN_TOLERANCE", "EN_EMITEXPON", "EN_DEMANDMULT")

	# check the arguments
	if( length(optioncode) != 1 ) stop("can only set one option at time")
	if (missing(optioncode)) {
		stop("Need to specify the analysis option code.")
	}
	if (is.character(optioncode)) {		
		code <- as.integer(match(optioncode, codeTable) - 1)		
	}
	else if (is.numeric(optioncode)) {
		code = as.integer(optioncode)
	}
	else if (is.integer(optioncode)) {
	    code <- optioncode	
	}
	else{
		stop("The analysis option code must be a character string or an integer.")
	}	
	if (any(is.na(code))) {
		stop("The analysis option code specified is incorrect.")
	}
	
	if( length(value) != 1) stop("can only set one option at a time")
	if( !is.numeric(value)) stop("value must be numeric")
	
	x <- .C("RENsetoption", code, value, as.integer(-1))
	check_epanet_error( x[[3]])
	return( invisible())
}


#' Sets flow units.
#' 
#' @param units	the choice of flow units. One of: "EN_CFS", "EN_GPM", "EN_MGD",
#'  "EN_IMGD", "EN_AFD", "EN_LPS", "EN_LPM", "EN_MLD", "EN_CMH", "EN_CMD"
#' @returns null invisibly
#' @details Flow units in liters or cubic meters implies that SI metric units
#' are used for all other quantities in addition to flow. Otherwise US Customary
#' units are employed.
#' @useDynLib epanet2toolkit RENsetflowunits
ENsetflowunits <- function(units){
   FlowUnitsEnums <-c("EN_CFS" ,"EN_GPM" 	,"EN_MGD" 	,"EN_IMGD" 	,"EN_AFD" ,"EN_LPS" ,"EN_LPM" ,"EN_MLD" ,"EN_CMH" ,"EN_CMD")
   flowUnitsVal <- lookup_enum_value(FlowUnitsEnums, units)
	x <- .C("RENsetflowunits", as.integer(flowUnitsVal), as.integer(-1))
	check_epanet_error(x[[2]])
}