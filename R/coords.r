#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#*****************************************

#' Get coordinates for a node 
#' 
#' @param nodeindex of node
#' @return vector of x,y coordinate
#' @export 
#' @useDynLib epanet2toolkit RENgetcoord
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetcoord(3)
#' ENclose()
ENgetcoord <- function( nodeindex ){

  if (missing(nodeindex)) {
    stop("Need to specify the node index.")
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
	 
	z <- .C("RENgetcoord", nodeindex, 0.0, 0.0, as.integer(-1))
	check_epanet_error( z[[4]])
	
	coord <- c( x= z[[2]], y = z[[3]])
	return( coord)
}

#' Set coordinates for a node 
#' 
#' @param nodeindex index of nodes for which to set coords
#' @param x coordinate
#' @param y coordinate
#' @return returns NULL invisibily on success or raises an error or warning
#' @export 
#' @useDynLib epanet2toolkit RENsetcoord
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt")
#' ENgetcoord(3)
#' ENsetcoord(3,33,44)
#' ENgetcoord(3)
#' ENclose()
ENsetcoord <- function( nodeindex, x, y){
  if (missing(nodeindex)) {
    stop("Need to specify the node index.")
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

  if( missing(x)) stop("need to specify x coordinate")
  if( missing(y)) stop("need to specify y coordinate")
  if( !is.numeric(x)) stop("coord values must be numeric")
  if( !is.numeric(y)) stop("coord values must be numeric")
  if( length(x) != 1 ) stop("x must have 1")
  if( length(y) != 1 ) stop("y must have 1")
  
  z <- .C("RENsetcoord", nodeindex, x, y, as.integer(-1))
  check_epanet_error( z[[4]])
  return( invisible() )
  
}
