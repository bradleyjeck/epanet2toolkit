#' ENgettitle
#' 
#' Retrieves the title lines of the project
#' @return character vector of title lines
#' @useDynLib epanet2toolkit RENgettitle
ENgettitle <- function(){

   # allocate character buffers for the title lines 
   row1 <- strrep(" ", 255)
   row2 <- strrep(" ", 255)
   row3 <- strrep(" ", 255)
   arg <- .C("RENgettitle", row1, row2, row3, as.integer(-1))
   err <- arg[[4]]
   check_epanet_error(err)
   title <- unlist(arg)[1:3]
   return(title)
}