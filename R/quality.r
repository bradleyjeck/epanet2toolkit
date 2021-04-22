
#*****************************************
#
# (C) Copyright IBM Corp. 2017, 2020
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************

#' Solve network water quality for all time periods
#' 
#' @export 
#' @return Returns NULL invisibly on success or throws an error or warning
#' @useDynLib epanet2toolkit RENsolveQ
#' @examples
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt","Net1.bin")
#' ENsolveH()
#' ENsetqualtype("EN_CHEM", "Chlorine", "mg/L", "")
#' ENsolveQ()
#' ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
#' file.remove("Net1.bin") 
ENsolveQ <- function(){
	
	x <- .C("RENsolveQ", as.integer(-1))
	check_epanet_error(x[[1]])
	return( invisible() )
}

#' Sets up for Water Quality analysis 
#' 
#' @export 
#' @return Returns NULL invisibly on success or throws an error or warning
#' @useDynLib epanet2toolkit RENopenQ
#' @examples
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENsolveH()
#' ENsetqualtype("EN_CHEM", "Chlorine", "mg/L", "")
#' ENopenQ()
#' ENinitQ(0)
#' ENrunQ()
#' ENcloseQ()
#' ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
ENopenQ <- function(){
	
	x <- .C("RENopenQ", as.integer(-1))
	check_epanet_error(x[[1]])
	return( invisible() )
}

#' Initialize water quality analysis 
#' 
#' @export 
#' @return Returns NULL invisibly on success or throws an error or warning
#' @useDynLib epanet2toolkit RENinitQ
#' @param saveFlag boolean or integer indicating whether to save quality results to a file
#' @details Call ENinitQ before running quality analysis using ENrunQ with ENnextQ or ENstepQ.  
#' ENopenQ must have been called prior to calling ENinitQ.  
#' Do not call ENinitQ with ENsolveQ.  
#' @examples
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENsolveH()
#' ENsetqualtype("EN_CHEM", "Chlorine", "mg/L", "")
#' ENopenQ()
#' ENinitQ(0)
#' ENrunQ()
#' ENcloseQ()
#' ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
ENinitQ <- function( saveFlag){
   if( length(saveFlag) != 1) stop("single input required")
   sf <- as.integer(saveFlag)	
   x <- .C("RENinitQ", sf, as.integer(-1) )
   check_epanet_error( x[[2]])
   return(invisible())
} 

#' Computs WQ results at current time .
#' 
#' @export 
#' @useDynLib epanet2toolkit RENrunQ
#' @return current simulation time in seconds    
#' @details used in a loop with ENnextQ() to run
#' an extended period WQ simulation. 
#' @examples
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENsolveH()
#' ENsetqualtype("EN_CHEM", "Chlorine", "mg/L", "")
#' ENopenQ()
#' ENinitQ(0)
#' ENrunQ()
#' ENcloseQ()
#' ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
ENrunQ <- function(){
        buf40 <- "0123456789012345678901234567890123456789"
	x <- .C("RENrunQ", buf40, as.integer(-1) )
	check_epanet_error( x[[2]])
	t <- charlong_to_int_or_char( x[[1]])
	return(t)
}

#' Advances WQ simulation to start of the next hydraulic time period.  
#' 
#' @export 
#' @useDynLib epanet2toolkit RENnextQ
#' @return  seconds until next hydraulic event occurs or
#'          0 if at the end of the simulation period. 
#' @examples
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENsolveH()
#' ENsetqualtype("EN_CHEM", "Chlorine", "mg/L", "")
#' ENopenQ()
#' ENinitQ(0)
#' ENrunQ()
#' ENnextQ()
#' ENrunQ()
#' ENcloseQ()
#' ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
ENnextQ <- function(){
        buf40 <- "0123456789012345678901234567890123456789"
	x <- .C("RENnextQ", buf40, as.integer(-1))
	check_epanet_error( x[[2]])
	t <- charlong_to_int_or_char( x[[1]])
	return(t)
}


#' Advances WQ simulation one water quality time step.
#' 
#' @return  time remaining in the overall simulation  
#' @export 
#' @useDynLib epanet2toolkit RENstepQ
ENstepQ <- function(){
	
        buf40 <- "0123456789012345678901234567890123456789"
        x <- .C("RENstepQ", buf40, as.integer(-1))
	check_epanet_error( x[[2]])
	t <- charlong_to_int_or_char( x[[1]])
	return(t)
}


#' Close water quality analysis and free allocated memory
#' 
#' @details Do not call this function if ENsolveQ is being used.  
#' @return Returns NULL invisibly; called for side effect
#' @useDynLib epanet2toolkit RENcloseQ
#' @export
ENcloseQ <- function(){
	x <- .C("RENcloseQ", as.integer(-1))
	check_epanet_error(x[[1]])
	return( invisible() )
}

#' get quality type
#' 
#' @export
#' @useDynLib epanet2toolkit RENgetqualtype
#' @return list of qualcode and trace node
#' @examples
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetqualtype()
#' ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
ENgetqualtype <- function(){
	x <- .C("RENgetqualtype", as.integer(0), as.integer(0), as.integer(-1))
	check_epanet_error( x[[3]])
	l <- list(qualcode = x[[1]], tracenode = x[[2]])
	return(l)
}




#' Set the type of water quality analysis called for.
#' 
#' \code{ENsetqualtype} sets the type of water quality analysis called for.
#' 
#' @export
#' @useDynLib epanet2toolkit RENsetqualtype
#' @param qualcode An integer or a character string, the water quality analysis code (see below).
#' @param chemname A character string, the name of the chemical being analyzed.
#' @param chemunits A character string, units that the chemical is measured in.
#' @param tracenode A character string, ID of node traced in a source tracing analysis.
#' @return returns NULL invisibly on success 
#' 
#' @details Water quality analysis codes are as follows:
#'
#'   \tabular{lrl}{
#'   \code{EN_NONE}			\tab 	0	\tab No quality analysis\cr
#'   \code{EN_CHEM}			\tab	1	\tab Chemical analysis\cr
#'   \code{EN_AGE}			\tab	2	\tab Water age analysis\cr
#'   \code{EN_TRACE}		\tab	3	\tab Source tracing
#'   }
#' 
#'   Chemical name and units can be an empty string if the analysis is not for a chemical.   
#'   The same holds for the trace node if the analysis is not for source tracing. 
#'   Note that the trace node is specified by ID and not by index.
#'   
#' @seealso \code{ENgetqualtype}
#' @examples
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetqualtype()
#' ENsetqualtype("EN_CHEM", "Chlorine", "mg/L", "")
#' ENgetqualtype()
#' ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
ENsetqualtype <- function( qualcode, chemname="", chemunits="", tracenode=""){
   
   codeTable <- c("EN_NONE","EN_CHEM","EN_AGE","EN_TRACE") 
   ## check inputs 
   code <- check_enum_code( qualcode, codeTable )	
   check_char_length_1(chemname)
   check_char_length_1(chemunits)
   check_char_length_1(tracenode)
   
   ## call toolkit func
   x <- .C("RENsetqualtype", code, chemname, chemunits, tracenode, as.integer(-1))
   check_epanet_error( x[[5]])
   return( invisible() )
	
} 

#' Get quality analysis information 
#'
#' @export
#' @useDynLib epanet2toolkit RENgetqualinfo 
#' @return list with elements: qualcode,  chemname, 
#' chemunits, tracenode 
#' @examples
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetqualinfo()
#' ENclose()
#' # clean-up the created files
#' file.remove("Net1.rpt") 
ENgetqualinfo <- function(){
        cn = "                 "
        cu = "                 "
	x <- .C("RENgetqualinfo", as.integer(-1), cn, cu, as.integer(0), as.integer(-1))
	check_epanet_error( x[[5]])
        cn = gsub("\\s*", "", x[[2]]) 
	y <- list( qualcode = x[[1]], chemname = cn, chemunits=x[[3]], tracenode=x[[4]])
	return(y)
}
