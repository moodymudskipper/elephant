#' Test if object is elephant
#'
#' Test if object is elephant
#' @param x object
#'
#' @export
is.elephant <- function(x) {
  "elephant" %in% class(x)
}

#' Convert elephant object to standard object
#'
#' Remove "elephant" class and attributes from object.
#' @param x object
#'
#' @export
forget <- function(x) {
  class(x) <- setdiff(class(x), "elephant")
  attr(x, "elephant") <- NULL
  attr(x, "calves")   <- NULL
  x
}

#' Print elephant object
#'
#' Print elephant object.
#' @inheritParams base::print
#'
#' @export
print.elephant <- function(x, ..., print.value = TRUE) {
  if(print.value) print(forget(x))
  rec_print(x)
  invisible(x)
}

rec_print <- function(x, nm = NULL, indent = 0){
  if(is.elephant(x))
    deparsed <- deparse(attr(x, "elephant"))
  else
    deparsed <- nm
  # deal with `{` calls
  deparsed <- gsub("^[ ]+([^ ]*)$","\\1;", deparsed)
  attrs <- attr(x, "calves")
  cat(strrep(" ", indent), deparsed, "#", short_summary(x), "\n")
  if(length(attrs))
    Map(rec_print, attrs, names(attrs), MoreArgs = list(indent = indent + 2))
  invisible()
}

short_summary <- function(x){
  out <- paste(setdiff(class(x), "elephant"), collapse= " ")
  if(!is.null(d <- dim(x)))
    out <- paste0(out,", dim: ",paste(d, collapse="x"))
  else if(!is.null(l <- length(x))) {
    if(l == 1)
      out <- paste0(out,", value: ",x)
    else
      out <- paste0(out,", length: ",l)
  }
  out
}

#' Create elephant object
#'
#' `:=` works like a regular assignment but creates an elephant object, which is
#' like a regular object but with a memory of how it was created, this memory is
#' recursive if variables used in the `value` expression are elephants themselves.
#'
#' @param x symbol to assign to
#'
#' @param value value to assign to x
#'
#' @export
`:=` <- function(x, value) {
  x_sym <- substitute(x)
  expr <- substitute(x <- value)
  elephant_vars <- Filter(exists, all.vars(expr[[3]]))
  calves <- mget(elephant_vars,envir = parent.frame(), inherits = TRUE)
  # calves <- Filter(is.elephant, calves)
  tryCatch(x <- value, error = function(e) {
    message("Elephant was killed in ", x_sym, " := ", deparse(expr[[3]]),"\n",
            "Use poach() to collect its memory")
    x <- NA
    class(x) <-  union("elephant", class(x))
    attr(x, "elephant") <- expr
    attr(x, "calves") <- calves
    globals$poached <- x
    stop(e)
  })
  class(x) <-  union("elephant", class(x))
  attr(x, "elephant") <- expr
  attr(x, "calves") <- calves
  assign(as.character(x_sym), x, envir = parent.frame())
  invisible(x)
}

globals <- new.env()

#' Retrieve a killed elephant's memories
#' @export
poach <- function() {
  globals$poached
}


#' calves
#'
#' Calves can be seen as the children element of an elephant object. It must be
#' clear that an elephant is not a list though, and its calves are stored in
#' a "calves" attribute.
#'
#' `list_calves()` will list of the calves of an elephant,
#' or of one of its calves, using recurive indexing, `calf()` will fetch one
#' particular calf.
#'
#' @param x elephant object
#' @param ... recursive index of the calf to access
#'
#' @rdname calves
#' @export
#' @examples
#' x := 1
#' y := x + 1
#' z := y + x
#' list_calves(z)
#' list_calves(z, "y")
#' calf(z, "y")
#' calf(z, "y", "x")
list_calves <- function(x, ...) {
  out <- attr(x, "calves")
  if(...length() == 0)
    return(out)
  else{
    do.call("list_calves", c(list(x=out[[..1]]), list(...)[-1]))
  }
}

#' @rdname calves
#' @export
calf <- function(x, ...) {
  out <- attr(x, "calves")[[..1]]
  if(...length() == 1)
    return(out)
  else{
    do.call("calf", c(list(x=out), list(...)[-1]))
  }
}



#
# test <- function(){
#   tryCatch(stop("a"), finally = print("s**t happens!"))
#   print("b")
# }
# test()
#
