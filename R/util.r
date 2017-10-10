#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Bradley J Eck
#
#  
#****************************************/

#' getOpenflag
#' 
#' gets current value of EPANET global variable Openflag
#' 
#' @details primary use of this function is to allow
#' package functions to check status of toolkit before 
#' calling a function
#' @export 
#' @useDynLib epanet2toolkit RgetOpenflag
#' @return boolean
#' @examples 
#' getOpenflag()
getOpenflag <- function(){
	
		x <- .C("RgetOpenflag", as.integer(-1))
		return( as.logical( x[[1]] ) ) 
	
}

#' getOpenHflag
#' 
#' gets current value of EPANET global variable OpenHflag
#' 
#' @details primary use of this function is to allow
#' package functions to check open/closed status of the 
#' toolkit's hydraulic solver before 
#' calling a hydraulic function
#' @export 
#' @useDynLib epanet2toolkit RgetOpenHflag
#' @return boolean
#' @examples 
#' getOpenHflag()
getOpenHflag <- function() {
  
  x <- .C("RgetOpenHflag", as.integer(-1))
  return( as.logical( x[[1]] ) ) 
  
}

# take an integer from a character vector
# and return an integer if possible
# or a trimmed character if not
charlong_to_int_or_char <- function( charlong ){
	
	# check the argument 
	if( !is.character(charlong)) stop("argument must be character")
	
	suppressWarnings( return_value <- as.integer( charlong))
	
	if( is.na(return_value)){
		return_value <- gsub("\\s*", "", charlong)
	}
	return( return_value)
	
}

check_char_length_1 <- function( x ){
	if( !is.character(x)) stop("must be character")
	if(length(x)!=1) stop("must have length 1")
}
