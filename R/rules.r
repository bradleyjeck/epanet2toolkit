#  Rule-Based Controls Functions

#' Adds a new rule-based control to a project
#' 
#' @param rule text of the rule following the format used in an EPANET input file.
#' @return null 
#' @useDynLib epanet2toolkit RENaddrule 
ENaddrule <- function(rule){

    res <- .C("RENaddrule", as.character(rule), as.integer(-1))
    check_epanet_error(res[[2]])
    return(invisible())
}  

#' Deletes an existing rule-based control
#'
#' @param index the index of the rule to be deleted (starting from 1).
#' @return null
#' @useDynLib epanet2toolkit RENdeleterule
ENdeleterule <- function(index){

    res <- .C("RENdeleterule",as.integer(index), as.integer(-1))
    check_epanet_error(res[[2]])
    return(invisible())
}
  

#' Retrieves summary information about a rule-based control.
#' 
#' @param index the rule's index (starting from 1).
#' @return list with components:
#'  nPremises number of premises in the rule's IF section;
#'  nThenActions number of actions in the rule's THEN section;
#'  nElseActions number of actions in the rule's ELSE section;
#'  priority the rule's priority value.
#' @useDynLib epanet2toolkit RENgetrule
ENgetrule <- function(index){

    res <- .C("RENgetrule", as.integer(index), 
              as.integer(-1), # 2 - nPremises
              as.integer(-1), # 3 - nThenActions
              as.integer(-1), # 4 - nElseActions 
              as.numeric(0) , # 5 - priority
              as.integer(-1) # 6 - error code
              )
    check_epanet_error(res[[6]])
    rule <- list(nPremises = res[[2]],
              nThenActions = res[[3]],
              nElseActions = res[[4]],
              priority = res[[5]])
    return(rule)
}


#' Gets the ID name of a rule-based control given its index.
#' 
#' @param index the rule's index (starting from 1).
#' @return rule's ID name.
#' @useDynLib epanet2toolkit RENgetruleID
ENgetruleID <- function(index){
    
    buff <- strrep(" ", EN_MAXID)
    res <- .C("RENgetruleID", as.integer(index), buff, as.integer(-1))
    check_epanet_error(res[[3]])
    return(res[[2]])
}

#' Gets the properties of a premise in a rule-based control.
#' 
#' @param ruleIndex the rule's index (starting from 1).
#' @param premiseIndex the position of the premise in the rule's list of premises  (starting from 1).
#' @returns list with components:
#' \describe{
#' \item{logop}{the premise's logical operator ( IF = 1, AND = 2, OR = 3 )}
#' \item{object}{the type of object the premise refers to}
#' \item{objIndex}{the index of the object (e.g. the index of a tank)}
#' \item{variable}{the object's variable being compared}
#' \item{relop}{the premise's comparison operator}
#' \item{status}{the status that the object's status is compared to}
#' \item{value}{the value that the object's variable is compared to}
#' }
#' @useDynLib epanet2toolkit RENgetpremise
ENgetpremise <- function(ruleIndex, premiseIndex){

    res <- .C("RENgetpremise", as.integer(ruleIndex),
                as.integer(premiseIndex), # 2 - premiseIndex
                as.integer(-1), # 3 - logop  
                as.integer(-1), # 4 - object
                as.integer(-1), # 5 - objIndex
                as.integer(-1), # 6 - variable
                as.integer(-1), # 7 - relop
                as.integer(-1), # 8 - status 
                as.numeric(-1), # 9 - value 
                as.integer(-1)  # 10 - error code
               )
    check_epanet_error(res[[10]])
    premise <- list(premiseIndex = res[[2]],
                    logop = res[[3]],
                    object = res[[4]],
                    objIndex = res[[5]],
                    variable = res[[6]],
                    relop = res[[7]],
                    status = res[[8]],
                    value = res[[9]])
    return(premise)
}

#' Sets the properties of a premise in a rule-based control.
#' 
#' @param ruleIndex the rule's index (starting from 1).
#' @param premiseIndex the position of the premise in the rule's list of premises.
#' @param logop the premise's logical operator ( IF = 1, AND = 2, OR = 3 ).
#' @param object the type of object the premise refers to
#' @param objIndex the index of the object (e.g. the index of a tank)
#' @param variable the object's variable being compared
#' @param relop the premise's comparison operator
#' @param status the status that the object's status is compared to
#' @param value the value that the object's variable is compared to.
#' @return null
#' @useDynLib epanet2toolkit RENsetpremise
ENsetpremise <- function(ruleIndex, premiseIndex, logop, object, objIndex, variable, relop, status, value){

    res <- .C("RENsetpremise",
              as.integer(ruleIndex),
              as.integer(premiseIndex),
              as.integer(logop),
              as.integer(object),
              as.integer(objIndex),
              as.integer(variable),
              as.integer(relop),
              as.integer(status),
              as.numeric(value),
              as.integer(-1)
              )
    check_epanet_error(res[[10]])
    return(invisible())
}

#' Sets the index of an object in a premise of a rule-based control
#'
#' @param ruleIndex the rule's index (starting from 1).
#' @param premiseIndex the premise's index (starting from 1).
#' @param objIndex the index of the premise's object (e.g. the index of a tank).
#' @return null
#' @useDynLib epanet2toolkit RENsetpremiseindex
ENsetpremiseindex <- function(ruleIndex, premiseIndex, objIndex){

    res <- .C("RENsetpremiseindex", 
              as.integer(ruleIndex),
              as.integer(premiseIndex),
              as.integer(objIndex),
              as.integer(-1) 
            )
    check_epanet_error(res[[4]])
    return(invisible())
} 

#' Sets the status being compared to in a premise of a rule-based control
#' 
#' @param ruleIndex the rule's index (starting from 1).
#' @param premiseIndex the premise's index (starting from 1).
#' @param status the status that the premise's object status is compared to (see @ref EN_RuleStatus).
#' @return null
ENsetpremisestatus <- function(ruleIndex, premiseIndex, status){

    res <- .C("RENsetpremisestatus",
              as.integer(ruleIndex),
              as.integer(premiseIndex),
              as.integer(status),
              as.integer(-1))
    check_epanet_error(res[[4]])
    return(invisible())
}  

#' Sets the value in a premise of a rule-based control
#' 
#' @param ruleIndex the rule's index (staring from 1).
#' @param premiseIndex the premise's index (starting from 1).
#' @param value The value that the premise's variable is compared to.
#' @return null
#' @useDynLib epanet2toolkit RENsetpremisevalue
ENsetpremisevalue <- function(ruleIndex, premiseIndex, value){

    res <- .C("RENsetpremisevalue",
               as.integer(ruleIndex),
               as.integer(premiseIndex),
               as.numeric(value),
               as.integer(-1))
    check_epanet_error(res[[4]])
    return(invisible())
}
  

#'  Gets properties of THEN action in rule-based control
#' 
#' @param ruleIndex the rule's index (starting from 1).
#' @param actionIndex the index of the THEN action to retrieve (starting from 1).
#' @return list with components:
#'  * linkIndex the index of the link in the action (starting from 1)
#'  * status the status assigned to the link
#'  * setting the value assigned to the link's setting
#' @export
#' @useDynLib epanet2toolkit RENgetthenaction
ENgetthenaction <- function(ruleIndex, actionIndex){

   res <- .C("RENgetthenaction", 
             as.integer(ruleIndex),
             as.integer(actionIndex),
             as.integer(-1), #lkidx,
             as.integer(-1), #stat
             as.numeric(-9999), #set
             as.integer(-1))
   check_epanet_error(res[[6]])
   lkidx <- res[[3]]
   stat  <- res[[4]]
   set   <- res[[5]]
   x <- list(linkIndex=lkidx, status=stat, setting=set)  
   return(x)
}

#' Set properties of THEN action in a rule-based control
#'
#' @param ruleIndex the rule's index (starting from 1)
#' @param actionIndex the index of the THEN action to modify (starting from 1)
#' @param linkIndex the index of the link in the action
#' @param status the new status assigned to the link 
#' @param setting the new value assigned to the link's setting
#' @return null
#' @export
#' @useDynLib epanet2toolkit RENsetthenaction
ENsetthenaction <-function(ruleIndex, actionIndex, linkIndex, status, setting){

    res <- .C("RENsetthenaction",
              as.integer(ruleIndex),
              as.integer(actionIndex),
              as.integer(linkIndex),
              as.integer(status),
              as.numeric(setting),
              as.integer(-1))
    check_epanet_error(res[[6]])
    return(invisible())
}
  
  
#' Gets the properties of an ELSE action in a rule-based control.
#'
#' @param ruleIndex the rule's index (starting from 1).
#' @param actionIndex the index of the ELSE action to retrieve (starting from 1).
#' @return list with the following components:
#'   \describe{
#'   \item{linkIndex}{ the index of the link in the action}
#'   \item{status}{the status assigned to the link}
#'   \item{setting}{the value assigned to the link's setting}
#' }
#' @export
#' @useDynLib epanet2toolkit RENgetelseaction
ENgetelseaction <- function(ruleIndex, actionIndex){

    res <- .C("RENgetelseaction",
              as.integer(ruleIndex),
              as.integer(actionIndex),
              as.integer(-1), #lkidx
              as.integer(-1), #stat
              as.numeric(-9999), # set
              as.integer(-1))
    check_epanet_error(res[[6]])
    lkidx <- res[[3]]
    stat  <- res[[4]]
    set   <- res[[5]]
    x <- list(linkIndex=lkidx, status=stat, setting=set)
    return(x)
}

#' Set properties of an ELSE action in a rule-based control
#'
#' @param ruleIndex the rule's index (starting from 1).
#' @param actionIndex the index of the ELSE action being modified (starting from 1).
#' @param linkIndex the index of the link in the action (starting from 1).
#' @param status the new status assigned to the link
#' @param setting the new value assigned to the link's setting.
#' @return null invisibly
#' @export
#' @useDynLib epanet2toolkit RENsetelseaction
ENsetelseaction <- function(ruleIndex, actionIndex, linkIndex, status, setting){
    
    res <- .C("RENsetelseaction",
              as.integer(ruleIndex),
              as.integer(actionIndex),
              as.integer(linkIndex),
              as.integer(status),
              as.numeric(setting),
              as.integer(-1))
    check_epanet_error(res[[6]])
    return(invisible())
}

#' Sets the priority of a rule-based control.
#'
#' @param index the rule's index (starting from 1).
#' @param priority the priority value assigned to the rule.
#' @return null
#' @export
#' @useDynLib epanet2toolkit RENsetrulepriority
ENsetrulepriority <- function(index, priority){

    res <- .C("RENsetrulepriority",
              as.integer(index),
              as.numeric(priority),
              as.integer(-1) )
    check_epanet_error(res[[3]])
    return(invisible())
}