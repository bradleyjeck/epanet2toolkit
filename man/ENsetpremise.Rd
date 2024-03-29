% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rules.r
\name{ENsetpremise}
\alias{ENsetpremise}
\title{Sets the properties of a premise in a rule-based control.}
\usage{
ENsetpremise(
  ruleIndex,
  premiseIndex,
  logop,
  object,
  objIndex,
  variable,
  relop,
  status,
  value
)
}
\arguments{
\item{ruleIndex}{the rule's index (starting from 1).}

\item{premiseIndex}{the position of the premise in the rule's list of premises.}

\item{logop}{the premise's logical operator ( IF = 1, AND = 2, OR = 3 ).}

\item{object}{the type of object the premise refers to}

\item{objIndex}{the index of the object (e.g. the index of a tank)}

\item{variable}{the object's variable being compared}

\item{relop}{the premise's comparison operator}

\item{status}{the status that the object's status is compared to}

\item{value}{the value that the object's variable is compared to.}
}
\value{
null
}
\description{
Sets the properties of a premise in a rule-based control.
}
