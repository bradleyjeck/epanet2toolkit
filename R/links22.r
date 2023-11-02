#' Add a link to the network
#'
#' @param id name of new link
#' @param type of new link, see details 
#' @param from_node id of source node for this link
#' @param to_node id of target node for this link
#' @details A new pipe is assigned a diameter of 10 inches (254 mm) and a length of 330
#' feet (~ 100 meters). Its roughness coefficient depends on the head loss formula in effect as follows:
#' - Hazen-Williams formula: 130
#' - Darcy-Weisbach formula: 0.5 millifeet (0.15 mm)
#' - Chezy-Manning formula: 0.01
#'
#' All other pipe properties are set to 0.
#'
#' A new pump has a status of EN_OPEN, a speed setting of 1, and has no pump
#' curve or power rating assigned to it.
#'
#' A new valve has a diameter of 10 inches (254 mm) and all other properties set to 0.
#'
#' Type must be one of: EN_CVPIPE, EN_PIPE, EN_PUMP, EN_PRV, EN_PSV, EN_PBV, EN_FCV, EN_TCV, EN_GPV
#' 
#' @return index of new link
#' @export 
#' @useDynLib epanet2toolkit RENaddlink
ENaddlink <- function(id, type, from_node, to_node){

    code <- lookup_enum_value(linkTypes, type)

    res <- .C("RENaddlink", as.character(id), code, as.character(from_node), as.character(to_node), 
              as.integer(-1), as.integer(-1))
    check_epanet_error(res[[6]])
    return(res[[5]])
}


#' Delete a link from the project.
#' 
#' @param index the index of the link to be deleted.
#' @param action The action taken if any control contains the link.
#' @details  If actionCode is EN_UNCONDITIONAL then the link and all simple and rule-based
#' controls that contain it are deleted. If set to EN_CONDITIONAL then the link
#' is not deleted if it appears in any control and error 261 is returned.
#' 
#' @export 
#' @useDynLib epanet2toolkit RENdeletelink
ENdeletelink <- function(index, action="EN_UNCONDITIONAL"){

    code <- lookup_enum_value(actionTypes, action)
    res <- .C("RENdeletelink", as.integer(index), code, as.integer(-1))
    check_epanet_error(res[[3]])
    return(invisible())
}

#' Change the ID of a link
#' 
#' @param index of the target link
#' @param newid new name for the link (no more than 30 characters)
#' @export
#' @useDynLib epanet2toolkit RENsetlinkid
ENsetlinkid <- function(index, newid){

    res <- .C("RENsetlinkid", as.integer(index), as.character(newid), as.integer(-1))
    check_epanet_error(res[[3]])
    return(invisible())
}

#' Change a link's type
#' 
#' @param index of link before type change
#' @param type the new type to change the link to (see details) 
#' @param action the action taken if any controls contain the link (see details)
#' @return link index after the type change 
#' @details  Link type is one of: EN_CVPIPE, EN_PIPE, EN_PUMP, EN_PRV, EN_PSV, EN_PBV, EN_FCV, EN_TCV, EN_GPV
#' 
#' If actionCode is EN_UNCONDITIONAL then all simple and rule-based controls that
#' contain the link are deleted when the link's type is changed. If set to
#' EN_CONDITIONAL then the type change is cancelled if the link appears in any
#' control and error 261 is returned.
#'
#' @export 
#' @useDynLib epanet2toolkit RENsetlinktype  
ENsetlinktype <- function(index, type, action="EN_UNCONDITIONAL"){

    tc <- lookup_enum_value(linkTypes, type)
    ac <- lookup_enum_value(actionTypes, action)
    res <- .C("RENsetlinktype", as.integer(index), tc, ac, as.integer(-1))
    check_epanet_error(res[[4]])
    return(res[[1]])
}


#' Set the indexes of a link's start- and end-nodes
#' 
#' @param index a link's index (starting from 1).
#' @param node1_index The index of the link's start node (starting from 1).
#' @param node2_index The index of the link's end node (starting from 1).
#' @export 
#' @useDynLib epanet2toolkit RENsetlinknodes
ENsetlinknodes <- function(index, node1_index, node2_index){
    res <- .C("RENsetlinknodes", as.integer(index), as.integer(node1_index), as.integer(node2_index), as.integer(-1) )
    check_epanet_error(res[[4]])
    return(invisible())
}


#' Get number of vertices for a link
#' 
#' @param index a link's index (starting from 1).
#' @return number of indices
#' @export 
#' @useDynLib epanet2toolkit RENgetvertexcount
ENgetvertexcount <- function(index){
    res <- .C("RENgetvertexcount", as.integer(index), as.integer(-1), as.integer(-1))
    check_epanet_error(res[[3]])
    return(res[[2]])
}

#' Get vertex coordinates
#' 
#' @param index a link's index (starting from 1).
#' @param vertex index of vertex for getting coords
#' @return list with elements x and y 
#' @export 
#' @useDynLib epanet2toolkit RENgetvertex
ENgetvertex <- function(index, vertex){

    res <- .C("RENgetvertex", as.integer(index), as.integer(vertex), as.numeric(-99999), as.numeric(-9999), as.integer(-1))
    check_epanet_error(res[[5]])
    return( list(x=res[[3]],
                 y=res[[4] ]) )
}

#' Set a link's vertices
#'
#' @param index a link's index
#' @param x numeric vector of x-coordinates
#' @param y numeric vector of y-coordinates
#' @export
#' @useDynLib epanet2toolkit RENsetvertices
ENsetvertices <- function(index, x, y){

    num <- length(x)
    res <- .C("RENsetvertices", as.integer(index), as.numeric(x), as.numeric(y), as.integer(num), as.integer(-1))
    check_epanet_error(res[[5]])
    return(invisible())
}