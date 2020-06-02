# this is to avoid creating elephant objects when using `<-` and expressions
# which would preserve class and attributes

#' methods for class 'elephant'
#' @inheritParams base::groupGeneric
#' @rdname elephant_methods
#' @export
Math.elephant <- function(x, ...){
  x <- forget(x)
  NextMethod()
}

#' @rdname elephant_methods
#' @export
Ops.elephant <- function(e1, e2){
  e1 <- forget(e1)
  e2 <- forget(e2)
  NextMethod()
}
#' @rdname elephant_methods
#' @export
Complex.elephant <- function(z){
  z <- forget(z)
  NextMethod()
}

#' @rdname elephant_methods
#' @export
Summary.elephant <- function (x, ..., na.rm = FALSE){
  x <- forget(x)
  NextMethod()
}

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
