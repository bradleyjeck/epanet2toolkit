# Nodal Demand Functions

#' Get type of demand model in use and its parameters
#' 
#' @return named list with parameters of the demand model
#' @export
#' @useDynLib epanet2toolkit RENgetdemandmodel
ENgetdemandmodel <- function(){

    res <- .C("RENgetdemandmodel", as.integer(-1), as.numeric(0.0), as.numeric(0.0),as.numeric(0.0), as.integer(-1))
    check_epanet_error(res[[5]])

    return (list( model = res[[1]],
                 pmin = res[[2]],
                 preq = res[[3]],
                 pexp = res[[5]] ) )
} 