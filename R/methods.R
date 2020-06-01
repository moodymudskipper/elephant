# this is to avoid creating elephant objects when using `<-` and expressions
# which would preserve class and attributes

#' methods for class 'elephant'
#' @param x object
#' @param ... passed to other methods
#' @param e1 object
#' @param e2 object
#' @rdname elephant_methods
#' @export
Math.elephant <- function(x, ...){
  x <- forget(x)
  NextMethod()
}

#' @rdname elephant_methods
#' @export
Ops.elephant <- Math.elephant

#' @rdname elephant_methods
#' @export
Complex.elephant <- Math.elephant

#' @rdname elephant_methods
#' @export
Summary.elephant <- Math.elephant

#' @rdname elephant_methods
#' @export
`+.elephant` <- function(e1,e2) forget(e1) + forget(e2)

#' @rdname elephant_methods
#' @export
`-.elephant` <- function(e1,e2) forget(e1) - forget(e2)

#' @rdname elephant_methods
#' @export
`*.elephant` <- function(e1,e2) forget(e1) * forget(e2)

#' @rdname elephant_methods
#' @export
`/.elephant` <- function(e1,e2) forget(e1) / forget(e2)

#' @rdname elephant_methods
#' @export
`^.elephant` <- function(e1,e2) forget(e1) ^ forget(e2)

#' @rdname elephant_methods
#' @export
`%%.elephant` <- function(e1,e2) forget(e1) %% forget(e2)

#' @rdname elephant_methods
#' @export
`%/%.elephant` <- function(e1,e2) forget(e1) %/% forget(e2)
