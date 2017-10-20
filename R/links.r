#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************

#########################################################
# Functions to retrieve information about network links
#########################################################


#' Retrieve the index of a link
#' 
#' \code{ENgetlinkindex} retrieves the index of a link with specified ID.
#' 
#' @export
#' @useDynLib epanet2toolkit enGetLinkIndex
#' @param linkid character
#' 
#' @return integer index of requested link
#' 
#' @note Link indexes are consecutive integers starting from 1.
#' 
#' @seealso \code{\link{ENgetlinkid} }
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetlinkindex("22")
#' ENclose()
ENgetlinkindex <- function(linkid) {
  
  if (missing(linkid)) {
    stop("Need to specify the link ID label(s).")
  }
  if (is.character(linkid)) {
    linkid = as.character(linkid)
  }
  else {
    stop("The link ID must be a character string.")
  }
  if (length(linkid) != 1 ) {
    stop("Can only get index for one link ID at a time.")
  }	
  
  index <- .Call("enGetLinkIndex", linkid)
  check_epanet_error(index$errorcode)
  
  return(index$value)
  
} 



#' Retrieve the ID label of a link
#' 
#' \code{ENgetlinkid} retrieves the ID label of the link given its index.
#' 
#' @export
#' @useDynLib epanet2toolkit enGetLinkID
#' @param linkindex integer specifying the link index.
#' 
#' @return character ID
#' 
#' @note Link indexes are consecutive integers starting from 1.
#' 
#' @seealso \code{\link{ENgetlinkindex} }
#' 
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetlinkid(1)
#' ENgetlinkid(12)
#' ENclose()
ENgetlinkid <- function(linkindex) {
  
  if (missing(linkindex)) {
    stop("Need to specify the link index(es).")
  }
  if (is.numeric(linkindex)) {
    linkindex = as.integer(linkindex)
  }
  else {
    stop("The link index must be an integer.")
  }
  if (length(linkindex) != 1 ) {
    stop("Can only get ID for one link index at a time.")
  }	
  
  linkid <- .Call("enGetLinkID", linkindex)
  check_epanet_error(linkid$errorcode)
  
  return(linkid$value)
  
}


#' Retrieve the type code for a link
#' 
#' @param linkindex for which type code is requested
#' 
#' @return integer type-code of the link
#' 
#' @note Link indexes are consecutive integers starting from 1. Link type codes
#'   consist of the following constants:
#'   \tabular{lll}{
#'   \code{EN_CVPIPE} \tab 0 \tab Pipe with Check Valve\cr
#'   \code{EN_PIPE}	  \tab 1 \tab Pipe\cr
#'   \code{EN_PUMP}	  \tab 2 \tab Pump\cr
#'   \code{EN_PRV}	  \tab 3 \tab Pressure Reducing Valve\cr
#'   \code{EN_PSV}	  \tab 4 \tab Pressure Sustaining Valve\cr
#'   \code{EN_PBV}	  \tab 5 \tab Pressure Breaker Valve\cr
#'   \code{EN_FCV}	  \tab 6 \tab Flow Control Valve\cr
#'   \code{EN_TCV}	  \tab 7 \tab Throttle Control Valve\cr
#'   \code{EN_GPV}	  \tab 8 \tab General Purpose Valve\cr
#'   }
#' 
#' @seealso \code{\link{ENgetlinkindex}}
#' @export
#' @useDynLib epanet2toolkit enGetLinkType
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetlinktype(1)
#' ENgetlinktype(12)
#' ENclose()
ENgetlinktype <- function(linkindex) {
  
  if (missing(linkindex)) {
    stop("Need to specify the link index(es).")
  }
  if (is.numeric(linkindex)) {
    linkindex = as.integer(linkindex)
  }
  else {
    stop("The link index must be an integer.")
  }
  if (length(linkindex) != 1 ) {
    stop("Can only get ID for one link index at a time.")
  }	
  
  linktype <- .Call("enGetLinkType", linkindex)
  check_epanet_error(linktype$errorcode)
  
  return(linktype$value)
  
} 


#' Retrieve the index of the end nodes of a link
#' 
#' @param linkindex integer specifying the link index
#' 
#' @return integer vector of node indices for this link
#' 
#' @note Node and link indexes are consecutive integers starting from 1.
#' 
#'   The From and To nodes are as defined for the link in the EPANET input file. The actual direction of
#'   flow in the link is not considered.
#' @seealso \code{\link{ENgetlinkindex} }
#' @export
#' @useDynLib epanet2toolkit enGetLinkNodes
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetlinknodes(1)
#' ENgetlinknodes(11)
#' ENclose()
ENgetlinknodes <- function(linkindex) {
  
  if (missing(linkindex)) {
    stop("Need to specify the link index(es).")
  }
  if (is.numeric(linkindex)) {
    linkindex = as.integer(linkindex)
  }
  else {
    stop("The link index must be an integer.")
  }
  if (length(linkindex) != 1 ) {
    stop("Can only get nodes for one link index at a time.")
  }
  
  linknodes <- .Call("enGetLinkNodes", linkindex)
  check_epanet_error(linknodes$errorcode)
  
  return(linknodes$value)
  
} 


#' Retrieve parameter value for a link
#' 
#' \code{ENgetlinkvalue} retrieves the value of a specific link parameter for a link.
#' 
#' @export
#' @useDynLib epanet2toolkit enGetLinkValue
#' @param linkindex index of the link
#' @param paramcode requested parameter type either as name or number
#' 
#' @return The parameter value of a specified link.
#' 
#' @note Link indexes are consecutive integers starting from 1.
#'   Link parameter codes consist of the following constants:
#'   \tabular{lrl}{
#'   \code{EN_DIAMETER}		\tab 	0	\tab Diameter\cr
#'   \code{EN_LENGTH}		\tab	1	\tab Length\cr
#'   \code{EN_ROUGHNESS}	\tab	2	\tab Roughness coeff.\cr
#'   \code{EN_MINORLOSS}	\tab	3	\tab Minor loss coeff.\cr
#'   \code{EN_INITSTATUS}	\tab	4	\tab Initial link status (0 = closed, 1 = open)\cr
#'   \code{EN_INITSETTING}	\tab	5	\tab Initial pipe roughness\cr
#' 							\tab 		\tab Initial pump speed\cr
#' 							\tab 		\tab Initial valve setting\cr
#'   \code{EN_KBULK}		\tab 	6	\tab Bulk reaction coeff.\cr
#'   \code{EN_KWALL}		\tab	7	\tab Wall reaction coeff.\cr
#'   \code{EN_FLOW}			\tab    8	\tab Flow rate\cr
#'   \code{EN_VELOCITY}		\tab    9	\tab Flow velocity\cr
#'   \code{EN_HEADLOSS}	    \tab   10	\tab Head loss\cr
#'   \code{EN_STATUS}		\tab   11	\tab Actual link status (0 = closed, 1 = open)\cr
#'   \code{EN_SETTING}		\tab   12	\tab Pipe roughness\cr
#' 							\tab  		\tab Actual pump speed\cr
#' 							\tab  		\tab Actal valve setting\cr
#'   \code{EN_ENERGY}		\tab   13	\tab Energy expended in kwatts
#'   }
#'   Parameters 8 - 13 (\code{EN_FLOW} through \code{EN_ENERGY}) are computed values. The others
#'   are design parameters.
#' 
#'   Flow rate is positive if the direction of flow is from the designated start node of the link to
#'   its designated end node, and negative otherwise.
#' 
#'   Values are returned in units which depend on the units used for flow rate in the EPANET
#'   input file.
#' 
#' @seealso \code{ENgetlinkindex} \code{\link{ENgetflowunits}}
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen(inp, "Net1.rpt")
#' ENgetlinkvalue(1, "EN_DIAMETER")
#' ENgetlinkvalue(1, "EN_LENGTH")
#' ENgetlinkvalue(8, "EN_DIAMETER")
#' ENgetlinkvalue(8, "EN_LENGTH")
#' ENclose()
ENgetlinkvalue <- function(linkindex, paramcode) {
  
  # check the arguments
  if (missing(linkindex)) {
    stop("Need to specify the link index(es).")
  }
  if (missing(paramcode)) {
    stop("Need to specify the parameter code(s).")
  }
  if (is.numeric(linkindex)) {
    linkindex = as.integer(linkindex)
  }
  else {
    stop("Link index must be an integer.")
  }
  paramcodeTable <- c("EN_DIAMETER", "EN_LENGTH", "EN_ROUGHNESS", "EN_MINORLOSS", "EN_INITSTATUS", 
                      "EN_INITSETTING", "EN_KBULK", "EN_KWALL", "EN_FLOW", "EN_VELOCITY", "EN_HEADLOSS", 
                      "EN_STATUS", "EN_SETTING", "EN_ENERGY")
  pc <- check_enum_code(paramcode,paramcodeTable)
 
  linkvalue <- .Call("enGetLinkValue", linkindex, pc)
  check_epanet_error(linkvalue$errorcode)
  
  return(linkvalue$value)
  
} 	


#' Set a parameter value for a link 
#' 
#' @param index of the link 
#' @param paramcode number or name of parameter code, see details 
#' @param value new value of the parameter.
#' @return Returns NULL invisibly on success or raises a warning or error.
#' 
#' @details Links are indexed starting from 1.
#'   
#'   Link parameter codes consist of the following constants:
#'   \tabular{lrl}{
#'   \code{EN_DIAMETER}		\tab 	0	\tab Diameter\cr
#'   \code{EN_LENGTH}		\tab	1	\tab Length\cr
#'   \code{EN_ROUGHNESS}	\tab	2	\tab Roughness coeff.\cr
#'   \code{EN_MINORLOSS}	\tab	3	\tab Minor loss coeff.\cr
#'   \code{EN_INITSTATUS}	\tab	4	\tab Initial link status (0 = closed, 1 = open)\cr
#'   \code{EN_INITSETTING}	\tab	5	\tab Pipe roughness\cr
#' 							\tab 		\tab Initial pump speed\cr
#' 							\tab 		\tab Initial valve setting\cr
#'   \code{EN_KBULK}		\tab 	6	\tab Bulk reaction coeff.\cr
#'   \code{EN_KWALL}		\tab	7	\tab Wall reaction coeff.\cr
#'   \code{EN_STATUS}		\tab   11	\tab Current pump or valve status (0 = closed, 1 = open)\cr
#'   \code{EN_SETTING}		\tab   12	\tab Current pump speed of valve setting.
#'   }
#' 
#'   Values are supplied in units which depend on the units used for flow rate in the EPANET input file 
#'   (see Units of Measurement). Use \code{EN_INITSTATUS} and \code{EN_INITSETTING} to set the design value 
#'   for a link's status or setting that exists prior to the start of a simulation. Use \code{EN_STATUS} and
#'   \code{EN_SETTING} to change these values while a simulation is being run (within the 
#'   \code{ENrunH} - \code{ENnextH} loop).
#'   
#' 
#'   If a control valve has its status explicitly set to \code{OPEN} or \code{CLOSED}, then to make it active again 
#'   during a simulation you must provide a new valve setting value using the \code{EN_SETTING} parameter.
#'   
#'   For pipes, either \code{EN_ROUGHNESS} or \code{EN_INITSETTING} can be used to change roughness.
#'   
#' @export
#' @useDynLib epanet2toolkit enSetLinkValue
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen(inp, "Net1.rpt")
#' ENgetlinkvalue(8, "EN_LENGTH")
#' ENsetlinkvalue(8, "EN_LENGTH", 3333)
#' ENgetlinkvalue(8, "EN_DIAMETER")
#' ENclose()
ENsetlinkvalue <- function(index, paramcode, value) {
  
  if (nargs() == 3) {		
    if (missing(index)) {
      stop("Need to specify the link index(es).")
    }	
    if (missing(paramcode)) {
      stop("Need to specify the parameter code(s).")
    }
    if (missing(value)) {
      stop("Need to specify the new value(s) of the link parameter(s).")
    }
    if (length(paramcode) != 1) {
      stop("One node index at a time.")
    }
    if (length(value) != 1) {
      stop("One value at a time.")
    }
  }
      codetable <- c("EN_DIAMETER", "EN_LENGTH", "EN_ROUGHNESS", "EN_MINORLOSS", "EN_INITSTATUS", 
                     "EN_INITSETTING", "EN_KBULK", "EN_KWALL", "EN_FLOW", "EN_VELOCITY", "EN_HEADLOSS", 
                     "EN_STATUS", "EN_SETTING", "EN_ENERGY")
  pc <- check_enum_code( paramcode, codetable) 

  out <- .Call("enSetLinkValue", index, pc, value)
  check_epanet_error(out$errorcode)

  return(invisible())
  
} 
