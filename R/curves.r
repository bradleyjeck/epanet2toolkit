
#' Adds a new data curve to a project.
#'
#' @param id The ID name of the curve to be added.
#' @details The new curve contains a single data point (1.0, 1.0).
#' @return null invisibly
#' @export
#' @useDynLib epanet2toolkit RENaddcurve
ENaddcurve <- function(id){

    res <- .C("RENaddcurve", id, as.integer(-1))
    check_epanet_error(res[[2]])
    return(invisible)
}


#' Deletes a data curve from a project
#'
#' @param index the data curve's index (starting from 1).
#' @return null invisibly
#' @export
#' @useDynLib epanet2toolkit RENdeletecurve
ENdeletecurve <- function(index){

    res <- .C("RENdeletecurve", index, as.integer(-1))
    check_epanet_error(res[[2]])
    return(invisible())
}

#' Retrieves the index of a curve given its ID name.
#'  
#' @param id the ID name of a curve.
#' @return The curve's index (starting from 1).
#' @export
#' @useDynLib epanet2toolkit RENgetcurveindex 
ENgetcurveindex <- function(id){

    res <- .C("RENgetcurveindex", id, as.integer(-1), as.integer(-1))
    check_epanet_error(res[[3]])
    return(res[[2]])
}

#' Retrieves the ID name of a curve given its index.
#'  
#' @param index a curve's index (starting from 1).
#' @return the curve's ID name.
#' @export
#' @useDynLib epanet2toolkit RENgetcurveid
ENgetcurveid <- function(index){

    buff <- strrep(" ", EN_MAXID)
    res <- .C("RENgetcurveid", as.integer(index), buff, as.integer(-1))
    check_epanet_error(res[[3]])
    return(res[[2]])
}


#' Changes the ID name of a data curve given its index.
#'  
#' @param index a data curve index (starting from 1).
#' @param id the data curve's new ID name.
#' @return null invisibly
#' @export
#' @useDynLib epanet2toolkit RENsetcurveid
ENsetcurveid <- function(index, id){

    res <- .C("RENsetcurveid", as.integer(index), id, as.integer(-1))
    check_epanet_error(res[[3]])
    return(invisible)
}  

#' Retrieves the number of points in a curve.
#'  
#' @param index a curve's index (starting from 1).
#' @return The number of data points assigned to the curve.
#' @export
#' @useDynLib epanet2toolkit RENgetcurvelen
ENgetcurvelen <- function(index){

    res <- .C("RENgetcurvelen", as.integer(index), as.integer(-1), as.integer(-1))
    check_epanet_error(res[[3]])
    return(res[[2]])
}

#' Retrieves a curve's type
#'
#' @param index a curve's index (starting from 1).
#' @return the curve's type
#' @export
#' @useDynLib epanet2toolkit RENgetcurvetype
ENgetcurvetype <- function(index){
    res <- .C("RENgetcurvetype", as.integer(index), as.integer(-1), as.integer(-1))
    check_epanet_error(res[[3]])
    ctype <- res[[2]]
    return( EN_CurveType[ctype+1])
}


#' Retrieves the value of a single data point for a curve.
#'   
#' @param curveIndex a curve's index (starting from 1).
#' @param pointIndex the index of a point on the curve (starting from 1).
#' @return list with the point's x-value and y-value
#' @export
#' @useDynLib epanet2toolkit RENgetcurvevalue
ENgetcurvevalue <- function(curveIndex, pointIndex){

    res <- .C("RENgetcurvevalue", as.integer(curveIndex), as.integer(pointIndex), 0.0, 0.0, as.integer(-1))
    check_epanet_error(res[[5]])
    val <- list( x = res[[3]], 
                 y = res[[4]] )
    return(val)
}

#' Sets the value of a single data point for a curve.
#'  
#' @param curveIndex a curve's index (starting from 1).
#' @param pointIndex the index of a point on the curve (starting from 1).
#' @param x the point's new x-value.
#' @param y the point's new y-value.
#' @return null invisibly
#' @export
#' @useDynLib epanet2toolkit RENsetcurvevalue
ENsetcurvevalue <- function(curveIndex, pointIndex, x, y){

    res <- .C("RENsetcurvevalue", as.integer(curveIndex), as.integer(pointIndex), 
              as.numeric(x), as.numeric(y), as.integer(-1))
    check_epanet_error( res[[5]])
    return(invisible())
}


# NOTE - opted to not implement ENgetcurve for R as it can be built from the other funcs