% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rules.r
\name{ENgetthenaction}
\alias{ENgetthenaction}
\title{Gets properties of THEN action in rule-based control}
\usage{
ENgetthenaction(ruleIndex, actionIndex)
}
\arguments{
\item{ruleIndex}{the rule's index (starting from 1).}

\item{actionIndex}{the index of the THEN action to retrieve (starting from 1).}
}
\value{
list with components:
 * linkIndex the index of the link in the action (starting from 1)
 * status the status assigned to the link
 * setting the value assigned to the link's setting
}
\description{
Gets properties of THEN action in rule-based control
}
