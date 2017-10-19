#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************

#' Open the EPANET Toolkit.
#' 
#' \code{ENopen} opens the EPANET Toolkit to analyze a particular water distribution system.
#' 
#' @export
#' @useDynLib epanet2toolkit enOpen
#' @param inpFileName A string, the name of the EPANET Input file.
#' @param rptFileName A string, the name of the EPANET Report file.
#' @param outFileName A string, the name of an optional binary Output file.
#' 
#' @return returns NULL invisibly on success or raises an error or warning. 
#' 
#' @note If there is no need to save an EPANET's binary Output file, then \code{outFileName}
#'   can be an empty string ("").
#'   
#'   If \code{rptFileName} is an empty string, reporting will be made to the operating system 
#'   \code{stdout} device (which is usually the console/terminal).
#'   
#'   \code{enOpen} must be called before any of the other toolkit functions are used. The only
#'   exception is \code{enEpanet}.
#' 
#' @seealso 
#' \code{ENclose}  
#' \url{http://wateranalytics.org/EPANET/group___file_management.html} 
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENclose()
ENopen <- function(inpFileName, rptFileName, outFileName) {
	
	# check the arguments
	if (missing(inpFileName)) {
		stop("Need to specify the name of the Input file.")
	}
	if (missing(rptFileName)) {
		stop("Need to specify the name of the Report file.")
	}
	if (missing(outFileName) || outFileName == "") {
		outFileName = " "
	}
	if (!(is.character(inpFileName) & is.character(rptFileName) & is.character(outFileName))) {
		stop("The input arguments must be character strings.")
	}	
	
	if( getOpenflag()){
		warning("Epanet toolkit was already open")
	} else { 
		errcode <- .Call("enOpen", c(inpFileName, rptFileName, outFileName))					
		check_epanet_error(errcode)
	}
	
	return( invisible() )
	
} 

#' Close down the EPANET Toolkit system.
#' 
#' \code{ENclose} closes the EPANET Toolkit system (including all files being processed).
#' 
#' @export
#' @useDynLib epanet2toolkit enClose
#' 
#' @note \code{ENclose} must be called when all processing has been completed, even if an error
#'   condition was encountered.
#' 
#' @seealso \code{\link{ENopen}}
#' \url{http://wateranalytics.org/EPANET/group___file_management.html} 
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENclose()
ENclose <- function() {

	if( !getOpenflag()){
		warning("Epanet toolkit already closed")
	} else { 
		errcode <- .Call("enClose")					
		check_epanet_error(errcode)
	}
	return( invisible() )
}





#' Get number of network elements.
#' 
#' \code{ENgetcount} retrieves the number of network components of a specific type.
#' 
#' @export
#' @useDynLib epanet2toolkit RENgetcount
#' @param compcode A character string, integer or numeric specifying the component code(s) 
#'   (see below).
#' 
#' @return The number of network components.
#' @seealso
#' \url{http://wateranalytics.org/EPANET/group___network_info.html}
#' @details Component codes consist of the following:
#'   \tabular{lll}{
#'   \code{EN_NODECOUNT}    \tab 0 \tab Nodes\cr
#'   \code{EN_TANKCOUNT}    \tab 1 \tab Reservoirs and tank nodes\cr
#'   \code{EN_LINKCOUNT}    \tab 2 \tab Links\cr
#'   \code{EN_PATCOUNT}     \tab 3 \tab Time patterns\cr
#'   \code{EN_CURVECOUNT}   \tab 4 \tab Curves\cr
#'   \code{EN_CONTROLCOUNT} \tab 5 \tab Simple controls
#'   }
#' 
#'   The number of junctions in a network equals the number of nodes minus the number of tanks and reservoirs.
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetcount(0)
#' ENgetcount("EN_NODECOUNT")
#' ENclose()
ENgetcount <- function(compcode) {
	
	codeTable = c("EN_NODECOUNT", "EN_TANKCOUNT", "EN_LINKCOUNT", "EN_PATCOUNT", "EN_CURVECOUNT", "EN_CONTROLCOUNT")
	
    # check the arguments
	if( length(compcode) != 1 ) stop("can only get one component at time")
	if (missing(compcode)) {
		stop("Need to specify the component code.")
	}
	if (is.character(compcode)) {		
		code <- as.integer(match(compcode, codeTable) - 1)		
	}
	else if (is.numeric(compcode)) {
		code = as.integer(compcode)
	}
	else if (is.integer(compcode)) {
		code <- compcode	
	}
	else{
		stop("The component code must be a character string or an integer.")
	}	
	if (any(is.na(code))) {
		stop("The analysis option code specified is incorrect.")
	}
	
	x <- .C("RENgetcount", code, as.integer(0), as.integer(-1))
	check_epanet_error( x[[3]])
	return( x[[2]])	
	
} 


#' Retrieve a code number indicating the units used to express all flow rates.
#' 
#' \code{ENgetflowunits} retrieves a code number indicating the units used to express all flow rates.
#' 
#' @export
#' @useDynLib epanet2toolkit enGetFlowUnits
#' @return An integer, the code numnber indicating the flow units.
#' 
#' @note Flow units codes are as follows:
#'   \tabular{lll}{
#' 		0	\tab = \code{EN_CFS} \tab	cubic feet per second\cr
#' 		1	\tab = \code{EN_GPM} \tab	gallons per minute\cr
#' 		2	\tab = \code{EN_MGD} \tab	million gallons per day\cr
#' 		3 	\tab = \code{EN_IMGD} \tab	Imperial mgd\cr
#' 		4	\tab = \code{EN_AFD} \tab	acre-feet per day\cr
#' 		5	\tab = \code{EN_LPS} \tab	liters per second\cr
#' 		6	\tab = \code{EN_LPM} \tab	liters per minute\cr
#' 		7	\tab = \code{EN_MLD} \tab	million liters per day\cr
#' 		8	\tab = \code{EN_CMH} \tab	cubic meters per hour\cr
#' 		9	\tab = \code{EN_CMD} \tab	cubic meters per day
#'   }
#' 
#'   Flow units are specified in the \code{[OPTIONS]} section of the EPANET Input file.
#' 
#'   Flow units in liters or cubic meters implies that metric units are used for all other quantities in 
#'   addition to flow. Otherwise US units are employed. (See Units of Measurement).
#' 
#' @seealso
#' \url{http://wateranalytics.org/EPANET/group___toolkit_options.html}
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetflowunits()
#' ENclose()
ENgetflowunits <- function() {
	
	codetable <- c("EN_CFS", "EN_GPM", "EN_MGD", "EN_IMGD",	"EN_AFD", "EN_LPS", "EN_LPM",
			"EN_MLD", "EN_CMH", "EN_CMD") 
	#flowunits <- enEvalGetFunction("enGetFlowUnits")
	flowunits <- .Call("enGetFlowUnits")
	names(flowunits) = codetable[flowunits + 1]
	return(flowunits)
	
} 



#' Retrieve the type of water quality analysis called for.
#' 
#' \code{ENgetqualtype} retrieves the type of water quality analysis called for.
#' 
#' @export
#' @useDynLib epanet2toolkit enGetQualType
#' @return A named integer vector, the water quality analysis code (see below) and
#'   the index of node traced in a source tracing analysis.
#' 
#' @note Water quality analysis codes are as follows: 
#'   \tabular{lll}{
#' 		\code{EN_NONE}  \tab  0  \tab  No quality analysis\cr
#' 		\code{EN_CHEM}  \tab  1  \tab  Chemical analysis\cr
#' 		\code{EN_AGE}   \tab  2  \tab  Water age analysis\cr
#' 		\code{EN_TRACE} \tab  3  \tab  Source tracing
#'   }
#' 
#'   The tracenode value will be 0 when the quality code is not \code{EN_TRACE}.
#' 
#' @seealso \code{ENsetqualtype}
#' \url{http://wateranalytics.org/EPANET/group___toolkit_options.html}
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetqualtype()
#' ENclose()
ENgetqualtype <- function() {
	
	codetable <- c("EN_NONE", "EN_CHEM", "EN_AGE", "EN_TRACE") 
	#qualtype <- enEvalGetFunction("enGetQualType")
	qualtype <- .Call("enGetQualType")
	names(qualtype) = c("qualcode", "tracenode")
	return(qualtype)
	
} 

