#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************


#' Retrieve the index of a node 
#' 
#' @export
#' @useDynLib epanet2toolkit enGetNodeIndex
#' @param nodeid A character string specifying the node ID.
#' 
#' @return An integer index of the specified node.
#' 
#' @note Node indexes are consecutive integers starting from 1.
#' 
#' @seealso 
#' \code{ENgetnodeid} 
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetnodeindex("10")
#' ENgetnodeindex("23")
#' ENclose()
ENgetnodeindex <- function(nodeid) {
  
  if (missing(nodeid)) {
    stop("Need to specify the node ID label(s).")
  }
  if (is.character(nodeid)) {
    nodeid = as.character(nodeid)
  }
  else {
    stop("The node ID must be a character string.")
  }
  if (length(nodeid) != 1 ) {
    stop("Can only get index for one node ID at a time.")
  }	
  
  index <- .Call("enGetNodeIndex", nodeid)
  check_epanet_error(index$errorcode)
  
  return(index$value)
  
} 



#' Retrieve the ID label a node.
#' 
#' \code{ENgetnodeid} retrieves the ID label a node from its index 
#' 
#' @export
#' @useDynLib epanet2toolkit enGetNodeID
#' @param nodeindex An integer node index
#' 
#' @return A character string, the ID label of the specified node.
#' 
#' @note Node indexes are consecutive integers starting from 1.
#' 
#' @seealso \code{ENgetnodeindex}
#'
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetnodeid(1)
#' ENgetnodeid(5)
#' ENgetnodeid(9)
#' ENclose()
ENgetnodeid <- function(nodeindex) {
  
  if (missing(nodeindex)) {
    stop("Need to specify the node index(es).")
  }
  if (is.numeric(nodeindex)) {
    nodeindex = as.integer(nodeindex)
  }
  else {
    stop("The node index must be an integer.")
  }
  if (length(nodeindex) != 1 ) {
    stop("Can only get ID for one node index at a time.")
  }	
  
  nodeid <- .Call("enGetNodeID", nodeindex)
  check_epanet_error(nodeid$errorcode)
  
  return(nodeid$value)
  
} 



#' Retrieve the node-type code 
#' 
#' \code{ENgetnodetype} retrieves the node-type code 
#' 
#' @export
#' @useDynLib epanet2toolkit enGetNodeType
#' @param nodeindex An integer specifying the node index.
#' 
#' @return  integer type-code of the node.
#' 
#' @note Node indexes are consecutive integers starting from 1. 
#' 
#'   Node type codes consist of the following constants:
#' 
#'   \tabular{lll}{
#'   \code{EN_JUNCTION}  \tab 0 \tab Junction node\cr
#'   \code{EN_RESERVOIR} \tab 1 \tab Reservoir node\cr
#'   \code{EN_TANK}      \tab 2 \tab Tank node
#'   }
#' 
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetnodetype(1)
#' ENgetnodetype(10)
#' ENgetnodetype(11)
#' ENclose()
ENgetnodetype <- function(nodeindex) {
  
  if (missing(nodeindex)) {
    stop("Need to specify the node index(es).")
  }
  if (is.numeric(nodeindex)) {
    nodeindex = as.integer(nodeindex)
  }
  else {
    stop("The node index must be an integer.")
  }
  if (length(nodeindex) != 1 ) {
    stop("Can only get ID for one node index at a time.")
  }	
  
  nodetype <- .Call("enGetNodeType", nodeindex)
  check_epanet_error(nodetype$errorcode)

  return(nodetype$value)
  
} 



#' Retrieve node parameter value.
#' 
#' \code{ENgetnodevalue} retrieves the values of specific node parameters.
#' 
#' @export
#' @useDynLib epanet2toolkit enGetNodeValue
#' @param nodeindex An integer vector specifying the node index.
#' @param paramcode An integer or character string, the parameter codes (see below).
#' 
#' @return parameter value 
#' 
#' @note Node indexes are consecutive integers starting from 1.
#'   
#'   Node parameter codes consist of the following constants:
#'   \tabular{lrl}{
#'   \code{EN_ELEVATION}  \tab 0  \tab Elevation\cr
#'   \code{EN_BASEDEMAND} \tab 1  \tab Base demand\cr
#'   \code{EN_PATTERN}    \tab 2  \tab Demand pattern index\cr
#'   \code{EN_EMITTER}    \tab 3  \tab Emitter coeff.\cr
#'   \code{EN_INITQUAL}   \tab 4  \tab Initial quality\cr
#'   \code{EN_SOURCEQUAL} \tab 5  \tab Source quality\cr
#'   \code{EN_SOURCEPAT}  \tab 6  \tab Source pattern index\cr
#'   \code{EN_SOURCETYPE} \tab 7  \tab Source type (see note below)\cr
#'   \code{EN_TANKLEVEL}  \tab 8  \tab Initial water level in tank\cr
#'   \code{EN_DEMAND}     \tab 9  \tab Actual demand\cr
#'   \code{EN_HEAD}       \tab 10 \tab Hydraulic head\cr
#'   \code{EN_PRESSURE}   \tab 11 \tab Pressure\cr
#'   \code{EN_QUALITY}    \tab 12 \tab Actual quality\cr
#'   \code{EN_SOURCEMASS} \tab 13 \tab Mass flow rate per minute of a chemical source
#'   }
#' 
#'   Parameters 9 - 13 (\code{EN_DEMAND} through \code{EN_SOURCEMASS}) are computed values. The
#'   others are input design parameters.
#' 
#'   Source types are identified with the following constants:
#'   \tabular{ll}{
#'    \code{EN_CONCEN}    \tab 0\cr
#'    \code{EN_MASS}      \tab 1\cr
#'    \code{EN_SETPOINT}  \tab 2\cr
#'    \code{EN_FLOWPACED} \tab 3
#'   }
#' 
#'   See \code{[SOURCES]} for a description of these source types.
#' 
#'   Values are returned in units which depend on the units used for flow rate in the EPANET
#'   input file (see Units of Measurement).
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetnodevalue(1, "EN_ELEVATION")
#' ENgetnodevalue(5, "EN_BASEDEMAND")
#' ENclose()
ENgetnodevalue <- function(nodeindex, paramcode ) {
  
  # check the arguments
  if (missing(nodeindex)) {
    stop("Need to specify the node index(es).")
  }
  if (missing(paramcode)) {
    stop("Need to specify the parameter code(s).")
  }
  if (is.numeric(nodeindex)) {
    nodeindex = as.integer(nodeindex)
  }
  else {
    stop("Node index must be an integer.")
  }
  paramcodeTable <- c("EN_ELEVATION", "EN_BASEDEMAND", "EN_PATTERN", "EN_EMITTER", "EN_INITQUAL", 
                      "EN_SOURCEQUAL", "EN_SOURCEPAT", "EN_SOURCETYPE", "EN_TANKLEVEL", "EN_DEMAND", "EN_HEAD", 
                      "EN_PRESSURE", "EN_QUALITY", "EN_SOURCEMASS")

  pc <- check_enum_code( paramcode, paramcodeTable) 

  nodevalue <- .Call("enGetNodeValue", nodeindex, pc )
  check_epanet_error(nodevalue$errorcode)
  
  return(nodevalue$value)
  
}




#' Set the parameter value for a node.
#' 
#' \code{ENsetnodevalue} sets parameter value for one node.
#' 
#' @export
#' @useDynLib epanet2toolkit enSetNodeValue
#' @param index An integer vector, the node index.
#' @param paramcode An integer vector, the parameter code (see Details below).
#' @param value A numeric vector, the new value of the parameter.
#' 
#' @return returns NULL invisibly on success or raises an error or warning.
#' 
#' @details Nodes are indexed starting from 1 in the order in which they were entered into the
#'   \code{[NODES]} section of the EPANET input file.
#'   
#'   Node parameter codes consist of the following constants:
#'   \tabular{lrl}{
#'   \code{EN_ELEVATION}  \tab 0  \tab Elevation\cr
#'   \code{EN_BASEDEMAND} \tab 1  \tab Base demand\cr
#'   \code{EN_PATTERN}    \tab 2  \tab Demand pattern index\cr
#'   \code{EN_EMITTER}    \tab 3  \tab Emitter coeff.\cr
#'   \code{EN_INITQUAL}   \tab 4  \tab Initial quality\cr
#'   \code{EN_SOURCEQUAL} \tab 5  \tab Source quality\cr
#'   \code{EN_SOURCEPAT}  \tab 6  \tab Source pattern index\cr
#'   \code{EN_SOURCETYPE} \tab 7  \tab Source type (see note below)\cr
#'   \code{EN_TANKLEVEL}  \tab 8  \tab Initial water level in tank\cr
#'   }
#' 
#'   Source types are identified with the following constants:
#'   \tabular{ll}{
#'    \code{EN_CONCEN}    \tab 0\cr
#'    \code{EN_MASS}      \tab 1\cr
#'    \code{EN_SETPOINT}  \tab 2\cr
#'    \code{EN_FLOWPACED} \tab 3
#'   }
#' 
#'   See \code{[SOURCES]} for a description of these source types.
#'  
#'   Values are supplied in units which depend on the units used for flow rate in the EPANET
#'   input file (see Units of Measurement).
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetnodevalue(3, "EN_ELEVATION")
#' ENsetnodevalue(3, "EN_ELEVATION", 777)
#' ENgetnodevalue(3, "EN_ELEVATION")
#' ENclose()
ENsetnodevalue <- function(index, paramcode = NULL, value = NULL) {
  
  if (nargs() == 3) {		
    if (missing(index)) {
      stop("Need to specify the node index(es).")
    }	
    if (missing(paramcode)) {
      stop("Need to specify the parameter code(s).")
    }
    if (missing(value)) {
      stop("Need to specify the new value(s) of the node parameter(s).")
    }
    if (length(paramcode) != 1) {
      stop("One node index at a time.")
    }
    if (length(value) != 1) {
      stop("One value at a time.")
    }
    if (is.character(paramcode)) {
      codetable <-  c("EN_ELEVATION", "EN_BASEDEMAND", "EN_PATTERN", "EN_EMITTER", "EN_INITQUAL", 
                      "EN_SOURCEQUAL", "EN_SOURCEPAT", "EN_SOURCETYPE", "EN_TANKLEVEL")
      ind <- match(paramcode, codetable)
      if (any(is.na(ind))) {
        stop("Invalid parameter code.")
      }
      paramcode <- as.integer(ind - 1)
    }
  }
  
  out <- .Call("enSetNodeValue", index, paramcode, value)
  check_epanet_error(out$errorcode)
  
  return(invisible())
  
}
