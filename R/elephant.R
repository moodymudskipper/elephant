#' @export
is.elephant <- function(x) "elephant" %in% class(x)

#' @export
forget <- function(x) {
  class(x) <- setdiff(class(x), "elephant")
  attr(x, "elephant") <- NULL
  attr(x, "calves")   <- NULL
  x
}

#' @export
print.elephant <- function(x) {
  print(forget(x))
  rec_print(x)
  invisible(x)
}

rec_print <- function(x, ident = 0){
  cat(strrep(" ", ident), deparse(attr(x, "elephant")),"\n")
  if(length(attr(x, "calves")))
    lapply(attr(x, "calves"), rec_print, ident + 2)
  invisible()
}

#' @export
`:=` <- function(x, value) {
  x_sym <- substitute(x)
  expr <- substitute(x <- value)
  x <- value
  class(x) <-  union("elephant", class(x))
  attr(x, "elephant") <- expr
  elephant_vars <- Filter(exists, all.vars(expr[[3]]))
  attr(x, "calves") <- Filter(
    is.elephant, mget(elephant_vars,envir = parent.frame(), inherits = TRUE))
  assign(as.character(x_sym), x, envir = parent.frame())
  invisible(x)
}


