#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************


#' Retrieve the ID label a time pattern
#' 
#' \code{ENgetpatternid} retrieves the ID label of a particular time pattern.
#' 
#' @export
#' @useDynLib epanet2toolkit enGetPatternID
#' @param patternindex An integer specifying the time pattern index.
#' 
#' @return A character string, the pattern ID label of the specified time pattern.
#' 
#' @note Pattern indexes are consecutive integers starting from 1. 
#' 
#' @seealso
#' \url{http://wateranalytics.org/EPANET/group___patterns.html}
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetpatternid(1)
#' ENclose()
ENgetpatternid <- function(patternindex) {
	
	if (missing(patternindex)) {
		stop("Need to specify the pattern index(es).")
	}
	if (is.numeric(patternindex)) {
		patternindex = as.integer(patternindex)
	}
	else {
		stop("The pattern index must be an integer.")
	}
  if (length(patternindex) != 1) {
    stop("One index at a time.")
  }
  
  patternid <- .Call("enGetPatternID", patternindex)
  check_epanet_error(patternid$errorcode)
  
  return(patternid$value)
	
} 

#' Retrieve the index a time pattern.
#' 
#' \code{ENgetpatternindex} retrieves the index of a time pattern.
#' 
#' @export
#' @useDynLib epanet2toolkit enGetPatternIndex
#' @param patternid A character string specifying the pattern ID
#' 
#' @return An integer, the index of the specified time pattern.
#' 
#' @note Pattern indexes are consecutive integers starting from 1.
#' @seealso
#' \url{http://wateranalytics.org/EPANET/group___patterns.html}
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetpatternindex("1")
#' ENclose()
ENgetpatternindex <- function(patternid) {
	
	if (missing(patternid)) {
		stop("Need to specify the pattern ID label(s).")
	}
	if (is.character(patternid)) {
		patternid = as.character(patternid)
	}
	else {
		stop("The pattern ID must be a character string.")
	}
  if (length(patternid) != 1) {
    stop("One ID at a time.")
  }
		patternindex <- .Call("enGetPatternIndex", patternid)
		check_epanet_error(patternindex$errorcode)
	
	return(patternindex$value)
	
} 

#' Retrieve the number of time periods in a time pattern.
#' 
#' \code{ENgetpatternlen} retrieves the number of time periods in a specific time pattern.
#' 
#' @export
#' @useDynLib epanet2toolkit enGetPatternLen
#' @param patternindex An integer specifying a time pattern index.
#' 
#' @return An integer, the time pattern length.
#' 
#' @note Pattern indexes are consecutive integers starting from 1.
#' 
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetpatternlen(1)
#' ENclose()
ENgetpatternlen <- function(patternindex) {
	
	if (missing(patternindex)) {
		stop("Need to specify the pattern index(es).")
	}
	if (is.numeric(patternindex)) {
		patternindex = as.integer(patternindex)
	}
	else {
		stop("The pattern index must be an integer.")
	}
  if (length(patternindex) != 1) {
    stop("One index at a time.")
  }
	
  patternlen <- .Call("enGetPatternLen", patternindex)
	check_epanet_error(patternlen$errorcode)
	
	return(patternlen$value)
	
} 


#' Retrieve the multiplier factor for a specific time period 
#' 
#' \code{ENgetpatternvalue} retrieves the multiplier factor for specific time periods in a pattern.
#' 
#' @export
#' @useDynLib epanet2toolkit enGetPatternValue
#' @param index An integer specifying the time pattern index.
#' @param period An integer or integer vector of the periods within the time pattern.
#' 
#' @return A numeric or numeric vector, the multiplier factor for the specific time pattern and period.
#' 
#' @note Pattern indexes and periods are consecutive integers starting from 1.
#' 
#' @seealso \code{ENgetpatternindex}, \code{ENgetpatternlen}, \code{ENsetpatternvalue}
#' \url{http://wateranalytics.org/EPANET/group___patterns.html}
#' 
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetpatternvalue(1,1)
#' ENgetpatternvalue(1,2)
#' ENgetpatternvalue(1,3)
#' ENclose()
ENgetpatternvalue <- function(index, period) {
	
	# check the arguments
	if (missing(index)) {
		stop("Need to specify the pattern index.")
	}
	if (missing(period)) {
		stop("Need to specify the time period.")
	}
	if (is.numeric(index)) {
		index = as.integer(index)
	}
	else {
		stop("The pattern indexes must be integers.")
	}
	if( length(index) != 1 ) stop("Only one pattern index at a time")
	dfflag = FALSE
	if (is.numeric(period)) {
		period = as.integer(period)
		dfflag = TRUE
	}	
	if (!is.integer(period)) {
		stop("The period parameter must be a integer.")
	}
	if (length(index) != 1) {
	  stop("One index at a time.")
	}
	if (length(period) != 1) {
	  stop("One period at a time.")
	}
	
	patternperiod <- .Call("enGetPatternValue", index, period)
	check_epanet_error(patternperiod$errorcode)
	
	return(patternperiod$value)

} 


#' Set all of the multiplier factors for a specific time pattern.
#' 
#' \code{ENsetpattern} sets all of the multiplier factors for a specific time pattern.
#' 
#' @export
#' @useDynLib epanet2toolkit enSetPattern
#' @param index An integer, the pattern index.
#' @param factors A numeric vector, the multiplier factors for the entire pattern.
#' 
#' @details Pattern indexes are consecutive integers starting from 1.
#' 
#'   Use this function to redefine (and resize) a time pattern all at once; use 
#'   \code{ENsetpatternvalue} to revise pattern factors in specific time periods of a pattern.
#' 
#' @seealso \code{ENgetpatternindex}, \code{ENgetpatternlen}, 
#'   \code{ENgetpatternvalue}, \code{ENsetpatternvalue}
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENsetpattern(1, 1:10)		
#' ENgetpatternvalue(1,1)
#' ENgetpatternvalue(1,10)
#' ENclose()
ENsetpattern <- function(index, factors) {
		
	if (missing(index)) {
		stop("Need to specify the time pattern index(es).")
	}	
	if (missing(factors)) {
		stop("Need to specify the time pattern multiplier factors.")
	}
	if (is.numeric(index)) {
		index <- as.integer(index)
	}
	else {
		stop("The time pattern indexes must be integers.")
	}
	if (length(index) != 1 ) {
		stop("Can only set for one index at a time.")
	}			
  
  out <- .Call("enSetPattern", index, as.numeric(factors), length(factors))
  check_epanet_error(out$errorcode)
  
  return(invisible())
	
} 

#' set pattern value
#' 
#' @param index index of pattern
#' @param period time period for setting the value
#' @param value value to set
#' @return returns NULL inivisbly on success
#' @export
#' @useDynLib epanet2toolkit enSetPatternValue
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetpatternvalue(1,3)
#' ENsetpatternvalue(1,3, 9.876)
#' ENgetpatternvalue(1,3)
#' ENclose()
ENsetpatternvalue <- function(index, period, value) {
  
  if (is.numeric(index)) {
    index <- as.integer(index)
  }
  else {
    stop("The time pattern index must be an integer.")
  }
  if (length(index) != 1) {
    stop("One period index at a time.")
  }
  if (length(period) != 1) {
    stop("One period at a time.")
  }
  
  ml <- max( length(index), length(period), length(value))
  if (ml != 1)stop("sets one value at a time")
  
  out <- .Call("enSetPatternValue", index, period, value)
  check_epanet_error(out$errorcode)
  
  return(invisible())
  
} 
