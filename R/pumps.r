#' Retrieves type of head curve used by a pump
#'
#' @param linkindex index of the pump
#' @return type of head curve
#' @export
#' @useDynLib epanet2toolkit RENgetpumptype
ENgetpumptype <- function(linkindex){

    res <- .C("RENgetpumptype", as.integer(linkindex), as.integer(-1), as.integer(-1))
    check_epanet_error(res[[3]])
    pump_type_int <- res[[2]] 
    pump_type_char <- EN_PumpType[pump_type_int+1]
    return(pump_type_char)
}



#' Retrieves index of head curve used by a pump
#'
#' @param linkindex index of the pump
#' @return index of head curve
#' @export
#' @useDynLib epanet2toolkit RENgetheadcurveindex
ENgetheadcurveindex <- function(linkindex){
    res <- .C("RENgetheadcurveindex", as.integer(linkindex), as.integer(-1), as.integer(-1))
    check_epanet_error(res[[3]])
    return( res[[2]])
}

#' Sets index of head curve used by a pump
#'
#' @param linkindex index of the pump
#' @param curveindex index of head curve to assign
#' @return null invisibly
#' @export
#' @useDynLib epanet2toolkit RENsetheadcurveindex
ENsetheadcurveindex <- function(linkindex, curveindex){
    res <- .C("RENsetheadcurveindex", as.integer(linkindex), as.integer(curveindex), as.integer(-1))
    check_epanet_error(res[[3]])
    return( invisible())
}