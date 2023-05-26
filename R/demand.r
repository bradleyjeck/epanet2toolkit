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


#' Appends a new demand to a junction node demands list.
#' 
#' @param nodeindex the index of a node (starting from 1).
#' @param base_demand the demand's base value.
#' @param demand_pattern the name of a time pattern used by the demand
#' @param demand_name the name of the demand's category
#' 
#' @export
#' @useDynLib epanet2toolkit RENadddemand
ENadddemand <- function(nodeindex, base_demand, demand_pattern, demand_name){

    res <- .C("RENadddemand", as.integer(nodeindex), as.numeric(base_demand),
               as.character(demand_pattern), as.character(demand_name),
               as.integer(-1))
    check_epanet_error(res[[5]])
    return(invisible())
}

#' Delete a demand from a junction node
#' 
#' @param nodeindex the index of a node (starting from 1).
#' @param demandindex the position of the demand in the node's demands list (starting from 1).
#' @export 
#' @useDynLib epanet2toolkit RENdeletedemand
ENdeletedemand <- function(nodeindex, demandindex){

    res <- .C("RENdeletedemand", as.integer(nodeindex), as.integer(demandindex), as.integer(-1))
    check_epanet_error(res[[3]])
    return(invisible())
}

#' Get number of demands for a junction node
#' 
#' @param nodeindex the index of a node (starting from 1).
#' @return number of demands
#' @export 
#' @useDynLib epanet2toolkit RENgetnumdemands
ENgetnumdemands <- function(nodeindex){
    res <- .C("RENgetnumdemands", as.integer(nodeindex), as.integer(-1), as.integer(-1))
    check_epanet_error(res[[3]])
    return(res[[2]])
}

#' Retrieves the index of a node's named demand category
#' 
#' @param nodeindex the index of a node (starting from 1).
#' @param demand_name the name of the demand's category
#' @return demand category index
#' @export
#' @useDynLib epanet2toolkit RENgetdemandindex
ENgetdemandindex <- function(nodeindex, demand_name){

    res <- .C("RENgetdemandindex", as.integer(nodeindex), as.character(demand_name), as.integer(-1), as.integer(-1))
    check_epanet_error(res[[4]])
    return(res[[3]])
}


#' Gets the base demand for one of a node's demand categories.
#' 
#' @param nodeindex a node's index (starting from 1).
#' @param demand_index the index of a demand category for the node (starting from 1).
#' @return the category's base demand.
#' @export 
#' @useDynLib epanet2toolkit RENgetbasedemand
ENgetbasedemand <- function(nodeindex, demand_index=1){
    res <- .C("RENgetbasedemand", as.integer(nodeindex), as.integer(demand_index), as.numeric(-999), as.integer(-1))
    check_epanet_error(res[[4]])
    return(res[[3]])
}

#' Sets the base demand for one of a node's demand categories.
#' 
#' @param nodeindex a node's index (starting from 1).
#' @param demand_index the index of a demand category for the node (starting from 1).
#' @param base_demand the category's base demand.
#' @export 
#' @useDynLib epanet2toolkit RENsetbasedemand
ENsetbasedemand <- function(nodeindex, demand_index=1, base_demand){
    res <- .C("RENsetbasedemand", as.integer(nodeindex), as.integer(demand_index), as.numeric(base_demand), as.integer(-1))
    check_epanet_error(res[[4]])
    return(invisible())
}


#' Gets the base demand for one of a node's demand categories.
#' 
#' @param nodeindex a node's index (starting from 1).
#' @param demand_index the index of a demand category for the node (starting from 1).
#' @return the category's base demand.
#' 
#' 
#' Retrieves index of a time pattern assigned to one of a node's demand categories.
#' 
#' @param nodeindex the node's index (starting from 1).
#' @param demand_index the index of a demand category for the node (starting from 1).
#' @return patIndex the index of the category's time pattern.
#' @details A returned pattern index of 0 indicates that no time pattern has been assigned to the
#' demand category.
#' @export 
#' @useDynLib epanet2toolkit RENgetdemandpattern
ENgetdemandpattern <- function(nodeindex, demand_index=1){

    res <- .C("RENgetdemandpattern", as.integer(nodeindex), as.integer(demand_index), as.integer(-1), as.integer(-1))
    check_epanet_error(res[[4]])
    return(res[[3]])
}


#' Sets the index of a time pattern used for one of a node's demand categories.
#' 
#' @param nodeindex a node's index (starting from 1). 
#' @param demand_index the index of one of the node's demand categories (starting from 1). 
#' @param pattern_index the index of the time pattern assigned to the category.
#' @details Specifying a pattern index of 0 indicates that no time pattern is assigned to the 
#' demand category.
#' @export 
#' @useDynLib epanet2toolkit RENsetdemandpattern 
ENsetdemandpattern <- function(nodeindex, demand_index, pattern_index){
    res <- .C("RENsetdemandpattern", as.integer(nodeindex), as.integer(demand_index), as.integer(pattern_index), as.integer(-1))
    check_epanet_error(res[[4]])
    return(invisible())
}


#' Retrieves the name of a node's demand category.
#' 
#' @param nodeindex a node's index (starting from 1).
#' @param demand_index the index of one of the node's demand categories (starting from 1).
#' @return The name of the selected category.
#' @export 
#' @useDynLib  epanet2toolkit RENgetdemandname
ENgetdemandname <- function(nodeindex, demand_index=1){

    buffer <- paste0(rep_len(" ",30), collapse='') 
    res <- .C("RENgetdemandname", as.integer(nodeindex), as.integer(demand_index), buffer, as.integer(-1))
    check_epanet_error(res[[4]])
    return(res[[3]])
}


#' Sets the name of a node's demand category.
#' 
#' @param nodeindex a node's index (starting from 1).
#' @param demand_index the index of one of the node's demand categories (starting from 1).
#' @param demand_name The name of the selected category. No more than 30 characters
#' @export 
#' @useDynLib  epanet2toolkit RENsetdemandname
ENsetdemandname <- function(nodeindex, demand_index, demand_name){

    if (nchar(demand_name) > 30){
        stop("demand_name cannot have more than 30 characters")
    }

    res <- .C("RENsetdemandname", as.integer(nodeindex), as.integer(demand_index), as.character(demand_name), as.integer(-1))
    check_epanet_error(res[[4]])
    return(res[[3]])
}