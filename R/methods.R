# this is to avoid creating elephant objects when using `<-` and expressions
# which would preserve class and attributes

#' @export
Math.elephant <- function(x, ...){
  class(x) <- setdiff(class(x), "elephant")
  attr(x, "elephant") <- NULL
  attr(x, "calves") <- NULL
  NextMethod()
}

#' @export
Ops.elephant <- Math.elephant

#' @export
Complex.elephant <- Math.elephant

#' @export
Summary.elephant <- Math.elephant

#' @export
`+.elephant` <- function(e1,e2) forget(e1) + forget(e2)

#' @export
`-.elephant` <- function(e1,e2) forget(e1) - forget(e2)

#' @export
`*.elephant` <- function(e1,e2) forget(e1) * forget(e2)

#' @export
`/.elephant` <- function(e1,e2) forget(e1) / forget(e2)

#' @export
`^.elephant` <- function(e1,e2) forget(e1) ^ forget(e2)

#' @export
`%%.elephant` <- function(e1,e2) forget(e1) %% forget(e2)

#' @export
`%/%.elephant` <- function(e1,e2) forget(e1) %/% forget(e2)
