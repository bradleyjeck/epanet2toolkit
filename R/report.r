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
#' @examples
#' # path to Net1.inp example file included with this package
#' inp <- file.path( find.package("epanet2toolkit"), "extdata","Net1.inp")  
#' ENopen( inp, "Net1.rpt", "Net1.bin")
#' ENsolveH()
#' ENsolveQ()
#' ENreport()
#' ENclose()
ENreport <- function(){

    x <- .C("RENreport", as.integer(-1))
    check_epanet_error(x[[1]])
    return( invisible() ) 
}
