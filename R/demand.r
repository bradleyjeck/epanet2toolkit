# Nodal Demand Functions

demand_model_lookup <- c("EN_DDA", #Demand driven analysis
                         "EN_PDA") #Pressure driven analysis
#' Get type of demand model in use and its parameters
#' 
#' @return named list with parameters of the demand model
#' @export
#' @useDynLib epanet2toolkit RENgetdemandmodel
ENgetdemandmodel <- function(){

    res <- .C("RENgetdemandmodel", as.integer(-1), as.numeric(-9999), as.numeric(-9999),as.numeric(-9999), as.integer(-1))
    check_epanet_error(res[[5]])

    code <- demand_model_lookup[ res[[1]] + 1 ]

    return (list( model = code,
                 pmin = res[[2]],
                 preq = res[[3]],
                 pexp = res[[4]]))
}

#' Sets the type of demand model to use and its parameters.
#' 
#' @param model  Type of demand model. EN_DDA for demand driven analysis or EN_PDA for pressure driven analysis
#' @param pmin  Pressure below which there is no demand
#' @param preq  Pressure required to deliver full demand
#' @param pexp  Pressure exponent in demand function
#' @export
#' @useDynLib epanet2toolkit RENsetdemandmodel
ENsetdemandmodel <- function(model, pmin, preq, pexp){

    code <- lookup_enum_value(demand_model_lookup,model)

    res <- .C("RENsetdemandmodel", as.integer(code), as.numeric(pmin), as.numeric(preq), as.numeric(pexp), as.integer(-1))
    check_epanet_error(( res[[5]]))
    return(invisible())
}