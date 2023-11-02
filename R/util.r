#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Bradley J Eck
#
#  
#****************************************/

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


lookup_enum_value <- function(codeTable, optioncode){

	# check the arguments
	if( length(optioncode) != 1 ) stop("can only get one option at time")
	if (is.character(optioncode)) {		
		code <- as.integer(match(optioncode, codeTable) - 1)		
	}
	else if (is.numeric(optioncode)) {
		code <- as.integer(optioncode)
	}
	else if (is.integer(optioncode)) {
	    code <- optioncode	
	}
	else{
		stop("This parameter must must be a character string or an integer.")
	}	
	if (any(is.na(code))) {
		stop("The code specified is incorrect.")
	}

	return(code) 
}