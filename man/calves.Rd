% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/elephant.R
\name{list_calves}
\alias{list_calves}
\alias{calf}
\title{calves}
\usage{
list_calves(x, ...)

calf(x, ...)
}
\arguments{
\item{x}{elephant object}

\item{...}{recursive index of the calf to access}
}
\description{
Calves can be seen as the children element of an elephant object. It must be
clear that an elephant is not a list though, and its calves are stored in
a "calves" attribute.
}
\details{
\code{list_calves()} will list of the calves of an elephant,
or of one of its calves, using recurive indexing, \code{calf()} will fetch one
particular calf.
}
\examples{
x := 1
y := x + 1
z := y + x
list_calves(z)
list_calves(z, "y")
calf(z, "y")
calf(z, "y", "x")
}
