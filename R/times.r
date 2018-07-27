#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************


#' Get the value of one or more specific analysis time parameters.
#' 
#' \code{ENgettimeparam} retrieves the value of one or more specific analysis time parameters.
#' 
#' @export
#' @useDynLib epanet2toolkit RENgettimeparam 
#' @param paramcode A character string or integer specifying the parameter code
#'   (see below).
#' 
#' @return A named integer with the value of the specified time parameter.
#' 
#' @details Time parameter codes consist of the following constants:
#'   \tabular{lll}{
#'   \code{EN_DURATION}     \tab   0  \tab    Simulation duration\cr
#'   \code{EN_HYDSTEP}      \tab   1  \tab    Hydraulic time step\cr
#'   \code{EN_QUALSTEP}     \tab   2  \tab    Water quality time step\cr
#'   \code{EN_PATTERNSTEP}  \tab   3  \tab    Time pattern time step\cr
#'   \code{EN_PATTERNSTART} \tab   4  \tab    Time pattern start time\cr
#'   \code{EN_REPORTSTEP}   \tab   5  \tab    Reporting time step\cr
#'   \code{EN_REPORTSTART}  \tab   6  \tab    Report starting time\cr
#'   \code{EN_RULESTEP}     \tab   7  \tab    Time step for evaluating rule-based controls\cr
#'   \code{EN_STATISTIC}    \tab   8  \tab    Type of time series post-processing used:\cr
#'                          \tab  	  \tab    0 = none\cr
#'                          \tab  	  \tab 	  1 = averaged\cr
#'                          \tab  	  \tab 	  2 = minimums\cr
#'                          \tab  	  \tab 	  3 = maximums\cr
#'                          \tab  	  \tab 	  4 = ranges\cr
#'   \code{EN_PERIODS}      \tab   9  \tab    Number of reporting periods saved to binary output file
#'   }
#' 
#' @examples
#' # path to Net1.inp example file included with this package 
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp") 
#' ENopen(inp, "Net1.rpt")
#' ENgettimeparam("EN_DURATION")
#' ENgettimeparam("EN_HYDSTEP")
#' ENclose()
ENgettimeparam <- function(paramcode) {
		
	codeTable = c("EN_DURATION", "EN_HYDSTEP", "EN_QUALSTEP", "EN_PATTERNSTEP", "EN_PATTERNSTART", 
					"EN_REPORTSTEP", "EN_REPORTSTART", "EN_RULESTEP", "EN_STATISTIC", "EN_PERIODS")
	# check the arguments
	if (missing(paramcode)) {
		stop("Need to specify the time parameter code.")
	}
	if (is.character(paramcode)) {		
		code <- as.integer(match(paramcode, codeTable) - 1)		
	}
	else if (is.numeric(paramcode)) {
		code = as.integer(paramcode)
	}
	else {
		stop("The time parameter code must be a character string or an integer.")
	}	
	if (any(is.na(code))) {
		stop("The time parameter code specified is incorrect.")
	}
	 
        buf40 <- "0123456789012345678901234567890123456789"
        x <- .C("RENgettimeparam", code, buf40, as.integer(-1))
	check_epanet_error(x[[3]])
	param_val <- charlong_to_int_or_char(x[[2]])
	if( is.character(param_val)) warning("returning character because R does not handle long integers, see ?integer")
	return(param_val)
	
}



#' Set the value of a time parameter.
#' 
#' \code{ENsettimeparam} sets the value of a time parameter.
#' 
#' @export
#' @useDynLib epanet2toolkit RENsettimeparam 
#' @param paramcode An integer or character
#' @param timevalue An integer or character value of the time parameters in seconds.
#' 
#' @details Time parameter codes consist of the following constants:
#'
#'   \tabular{lrl}{
#' 	 \code{EN_DURATION}		\tab	0	\tab	Simulation duration\cr
#' 	 \code{EN_HYDSTEP}  	\tab	1	\tab	Hydraulic time step\cr
#' 	 \code{EN_QUALSTEP}		\tab	2	\tab	Water quality time step\cr
#'   \code{EN_PATTERNSTEP}	\tab	3	\tab	Time pattern time step\cr
#'   \code{EN_PATTERNSTART}	\tab	4	\tab	Time pattern start time\cr
#' 	 \code{EN_REPORTSTEP}	\tab	5	\tab	Reporting time step\cr
#' 	 \code{EN_REPORTSTART}	\tab	6	\tab	Reporting starting time\cr
#' 	 \code{EN_RULESTEP}		\tab	7	\tab	Time step for evaluating rule-based controls\cr
#' 	 \code{EN_STATISTIC}	\tab	8	\tab	Type of time series post-processing to use:\cr
#' 							\tab		\tab	\code{EN_NONE} (0) = none\cr
#' 							\tab		\tab	\code{EN_AVERAGE} (1) = averaged\cr
#' 							\tab		\tab	\code{EN_MINIMUM} (2) = minimums\cr
#' 							\tab		\tab	\code{EN_MAXIMUM} (3) = maximums\cr
#' 							\tab		\tab	\code{EN_RANGE} (4) = ranges
#'   }
#' 
#'   Do not change time parameters after calling ENinitH in a hydraulic analysis or 
#'   \code{ENinitQ} in a water quality analysis
#' 
#' 
#' @examples
#' # path to Net1.inp example file included with this package 
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp") 
#' ENopen(inp, "Net1.rpt")
#' ENgettimeparam("EN_HYDSTEP")
#' ENsettimeparam("EN_HYDSTEP", 600)
#' ENgettimeparam("EN_HYDSTEP")
#' ENclose()
ENsettimeparam <- function(paramcode, timevalue) {

	if(length(paramcode) > 1) stop("one param at a time")
	if(length(timevalue) > 1) stop("one param at a time")
	
	codetable <- c("EN_DURATION", "EN_HYDSTEP", "EN_QUALSTEP", 
			"EN_PATTERNSTEP", "EN_PATTERNSTART", "EN_REPORTSTEP",
			"EN_REPORTSTART", "EN_RULESTEP", "EN_STATISTIC")
	
	if (is.character(paramcode)) {		
		code <- as.integer(match(paramcode, codetable) - 1)		
	} else if( is.numeric(paramcode)){
		code <- as.integer(paramcode)
	} else if( is.integer(paramcode)){
		code <- paramcode
	} else {
		stop(paste("paramcode cannot be of class", class(paramcode)) )
	}
	
	value <- as.character(timevalue)
	x <- .C("RENsettimeparam", code, value , as.integer(-1))
	check_epanet_error(x[[3]])
	return( invisible() )
	
} 
