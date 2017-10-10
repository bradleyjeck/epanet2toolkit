#*****************************************
#
# (C) Copyright IBM Corp. 2017
# Author: Ernesto Arandia & Bradley J Eck
#
#****************************************/

#' Write simulation report to the report file
#'
#' @export
#' @useDynLib epanet2toolkit RENreport
ENreport <- function(){

    x <- .C("RENreport", as.integer(-1))
    check_epanet_error(x[[1]])
    return( invisible() ) 
}
