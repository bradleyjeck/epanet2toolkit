#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************



check_epanet_error <- function( rv ){
	
	if( !is.integer(rv)) stop("rv must be integer")

    goodMsg <- NA
	#try(goodMsg <- ENgeterror(rv))
	
	if( rv == 0){
		return()
	}  else if( rv > 100){
		# return values greater than 100 are fatal errors
		if( is.na(goodMsg)){
		    msg <- paste("epanet error ", rv)
		} else {
			msg <- goodMsg
		}
		stop(msg)
	} else if( rv <= 100 ){
		# return value 100 or less are warnings; continue evaluating
		if (is.na(goodMsg)){
		  # unable to obtain a good message so just return the error code
		  msg <- paste("epanet warning ", rv)
		} else {
			msg <- goodMsg
		}
		warning(msg)
	}
}

check_enum_code <- function( mycode, mytable){
	
	if( !is.character(mytable)) stop("table must be character vector")

	if( length(mycode) != 1 ) stop("code must have length of 1")
	
	# check the arguments
	if (missing(mycode)) {
		stop("Need to specify the time parameter code.")
	}
	if (is.character(mycode)) {		
		code <- as.integer(match(mycode, mytable) - 1)		
	}
	else if (is.numeric(mycode)) {
		code = as.integer(mycode)
	}
	else {
		stop("The code must be a character, integer, or number. ")
	}	
	if (any(is.na(code))) {
		stop("The time parameter code specified is incorrect.")
	}
	
	return( code )
	
}